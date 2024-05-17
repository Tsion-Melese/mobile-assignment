import 'package:flutter/material.dart';
import 'package:mobilefrontend/auth/view/registration_form.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RegistrationForm(), // Use the RegistrationForm widget here
        ),
      ),
    );
  }
}
