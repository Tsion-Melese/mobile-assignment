import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/auth_bloc.dart';
import 'package:mobilefrontend/auth/bloc/auth_event.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          TextFormField(
            controller: _firstnameController,
            decoration: const InputDecoration(
              labelText: 'Firstname',
            ),
          ),
          TextFormField(
            controller: _lastnameController,
            decoration: const InputDecoration(
              labelText: 'Lastname',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Set role to "USER" and dispatch a RegisterEvent with form data
                BlocProvider.of<AuthBloc>(context).add(
                  RegisterEvent(
                    username: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    firstName: _firstnameController.text,
                    lastName: _lastnameController.text,
                    role: 'USER',
                  ),
                );
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
