import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryfront/user/data_provider/user_data.dart';
import 'package:tryfront/user/model/updateuser_model.dart';
import 'package:tryfront/user/repo/user_repo.dart';

class EditProfilePage extends StatefulWidget {
  final UpdateUserDto initialData; // Pass initial profile data

  const EditProfilePage({Key? key, required this.initialData})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>(); // Create form key for validation
  late final TextEditingController _emailController; // Email text controller
  late final TextEditingController
      _usernameController; // Username text controller
  late final UpdateUserDto _originalData; // Store initial data for comparison
  late final UpdateUserDto
      _updatedData; // Declare updatedData variable with default value

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial data
    _emailController = TextEditingController(text: widget.initialData.email);
    _usernameController =
        TextEditingController(text: widget.initialData.username);
    _originalData = UpdateUserDto(
      email: widget.initialData.email,
      username: widget.initialData.username,
    ); // Save original data
    _updatedData =
        UpdateUserDto(email: '', username: ''); // Initialize updatedData
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    // Validate form and build update data based on changes
    if (_formKey.currentState!.validate()) {
      final updatedEmail = _emailController.text == _originalData.email
          ? _originalData.email
          : _emailController.text;
      final updatedUsername = _usernameController.text == _originalData.username
          ? _originalData.username
          : _usernameController.text;
      final updatedData =
          UpdateUserDto(email: updatedEmail, username: updatedUsername);

      try {
        final dio = Dio();
        final sharedPreferences = await SharedPreferences.getInstance();
        final userDataProvider = UserDataProvider(dio, sharedPreferences);
        final userRepository = ConcreteUserRepository(userDataProvider);

        await userRepository
            .updateProfile(updatedData); // Call updateProfile on the instance
        Navigator.pop(
            context, updatedData); // Pass updatedData back to ProfilePage

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller:
                    _emailController, // Assign controller to the email field
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress, // Set keyboard type
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address.';
                  }
                  // Add more complex email validation if needed (e.g., regex)
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller:
                    _usernameController, // Assign controller to the username field
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username.';
                  }
                  // Add username validation rules if needed (e.g., length, characters)
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
