import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryfront/auth/bloc/registration_auth_bloc.dart';
import 'package:tryfront/auth/data_provider/auth_data_provider.dart';
import 'package:tryfront/auth/model/auth_model.dart';
import 'package:tryfront/auth/repos/auth_repo.dart';
import 'package:tryfront/auth/view/loginForm.dart';
import 'package:tryfront/auth/view/register.dart';

void main() async {
  // Create an instance of the AuthDataProvider
  final authDataProvider = AuthDataProvider(baseUrl: 'http://localhost:3000');

  // Create an instance of the AuthRepository
  final authRepository = AuthRepository(dataProvider: authDataProvider);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AuthBloc(authRepository: authRepository),
        child: RegistrationPage(),
      ),
    );
  }
}
