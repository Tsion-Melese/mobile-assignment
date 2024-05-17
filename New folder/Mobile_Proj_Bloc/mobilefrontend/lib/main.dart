import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/auth_bloc.dart';
import 'package:mobilefrontend/auth/data_provider/registration_data_provider.dart';
import 'package:mobilefrontend/auth/repository/registration_repo.dart';
import 'package:mobilefrontend/auth/view/registration_page.dart';

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
