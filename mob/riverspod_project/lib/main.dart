import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverspod_project/auth/registration_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Riverpod Registration Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RegistrationPage(),
      ),
    );
  }
}
