import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverspod_project/auth/registration_model.dart';
import 'package:riverspod_project/auth/repository_.dart';

final emailControllerProvider = Provider((_) => TextEditingController());
final passwordControllerProvider = Provider((_) => TextEditingController());
final usernameControllerProvider = Provider((_) => TextEditingController());
final firstNameControllerProvider = Provider((_) => TextEditingController());
final lastNameControllerProvider = Provider((_) => TextEditingController());

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>(); // Define _formKey here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final usernameController = ref.watch(usernameControllerProvider);
    final firstNameController = ref.watch(firstNameControllerProvider);
    final lastNameController = ref.watch(lastNameControllerProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          DropdownButtonFormField<Role>(
            value: Role.USER,
            items: Role.values.map((Role role) {
              return DropdownMenuItem<Role>(
                value: role,
                child: Text(role.toString()),
              );
            }).toList(),
            onChanged: (Role? newValue) {},
            decoration: InputDecoration(labelText: 'Role'),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, register user
                ref.read(authRepositoryProvider).register(
                      RegistrationData(
                        email: emailController.text,
                        password: passwordController.text,
                        username: usernameController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        role: Role
                            .USER, // You can change this based on dropdown value
                      ),
                    );
              }
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
