import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/auth/model/login_model.dart';
import 'package:mobileriverpod/auth/provider/login_riverspod_provider.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    late String _email = '';
    late String _password = '';

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
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final email = _email;
                  final password = _password;
                  final role = Role.USER;

                  final authRepository =
                      await ref.read(authRepositoryProvider.future);

                  if (authRepository != null) {
                    authRepository.login(email, password, role);
                  } else {
                    // Handle the case where authRepository is null
                  }
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
