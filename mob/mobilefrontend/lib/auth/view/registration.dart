import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/auth_bloc.dart';
import 'package:mobilefrontend/auth/bloc/auth_event.dart';
import 'package:mobilefrontend/auth/data_provider/registration_data_provider.dart';
import 'package:mobilefrontend/auth/repository/registration_repo.dart';
import 'package:mobilefrontend/auth/view/admin_registration_page.dart';

class UserRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(
            authRepository: AuthRepository(dataProvider: AuthDataProvider())),
        child: AdminRegistrationForm(),
      ),
    );
  }
}

class UserRegistrationForm extends StatefulWidget {
  @override
  _UserRegistrationFormState createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late String _username;
  late String _firstName;
  late String _lastName;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            SizedBox(height: 16), // Add spacing between fields
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
              obscureText: true,
            ),
            SizedBox(height: 16), // Add spacing between fields
            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              onSaved: (value) => _username = value!,
            ),
            SizedBox(height: 16), // Add spacing between fields
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
              onSaved: (value) => _firstName = value!,
            ),
            SizedBox(height: 16), // Add spacing between fields
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
              onSaved: (value) => _lastName = value!,
            ),
            SizedBox(height: 16), // Add spacing between fields
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                    email: _email,
                    password: _password,
                    username: _username,
                    firstName: _firstName,
                    lastName: _lastName,
                  ));
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
