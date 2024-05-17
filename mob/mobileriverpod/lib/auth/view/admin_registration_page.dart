import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/auth/model/registration_model.dart';
import 'package:mobileriverpod/auth/provider/register_riverspod_provider.dart';

class AdminRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends ConsumerWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.read(authRepositoryProvider);

    final _formKey = GlobalKey<FormState>();
    late String _email = '';
    late String _password = '';
    late String _username = '';
    late String _firstName = '';
    late String _lastName = '';

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final registrationData = RegistrationData(
                    email: _email,
                    password: _password,
                    username: _username,
                    firstName: _firstName,
                    lastName: _lastName,
                    role: Role.ADMIN,
                  );
                  authRepository.register(registrationData);
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
