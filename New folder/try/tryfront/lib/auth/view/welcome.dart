import 'package:flutter/material.dart';
import 'package:tryfront/auth/model/auth_model.dart'; // Assuming User model

class WelcomePage extends StatelessWidget {
  final User user;

  const WelcomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.username}!'),
            // Add any additional content you want on the WelcomePage
          ],
        ),
      ),
    );
  }
}
