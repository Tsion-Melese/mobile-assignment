import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobilefrontend/user/data_provider/user_data_provider.dart';
import 'package:mobilefrontend/user/model/update_user_model.dart';
import 'package:mobilefrontend/user/repostory/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late final TextEditingController
      _firstnameController; // Firstname text controller
  late final TextEditingController
      _lastnameController; // Lastname text controller
  late final UpdateUserDto _originalData; // Store initial data for comparison

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial data
    _emailController = TextEditingController(text: widget.initialData.email);
    _usernameController =
        TextEditingController(text: widget.initialData.username);
    _firstnameController =
        TextEditingController(text: widget.initialData.firstName);
    _lastnameController =
        TextEditingController(text: widget.initialData.lastName);
    _originalData = widget.initialData;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    // Validate form and build update data based on changes
    if (_formKey.currentState!.validate()) {
      final updatedEmail = _emailController.text == _originalData.email
          ? _originalData.email
          : _emailController.text;
      final updatedFirstName =
          _firstnameController.text == _originalData.firstName
              ? _originalData.firstName
              : _firstnameController.text;
      final updatedLastName = _lastnameController.text == _originalData.lastName
          ? _originalData.lastName
          : _lastnameController.text;
      final updatedData = UpdateUserDto(
        email: updatedEmail,
        firstName: updatedFirstName,
        lastName: updatedLastName,
      );

      try {
        final dio = Dio();
        final sharedPreferences = await SharedPreferences.getInstance();
        final userDataProvider = UserDataProvider(dio, sharedPreferences);
        final userRepository = ConcreteUserRepository(userDataProvider);

        await userRepository.updateProfile(updatedData);
        Navigator.pop(context, updatedData);

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
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
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
                controller: _usernameController,
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
              TextFormField(
                controller: _firstnameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name.';
                  }
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
