import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/auth_bloc.dart';
import 'package:mobilefrontend/auth/data_provider/registration_data_provider.dart';
import 'package:mobilefrontend/auth/repository/registration_repo.dart';
import 'package:mobilefrontend/auth/view/admin_registration_page.dart';
import 'package:mobilefrontend/auth/view/registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                authRepository:
                    AuthRepository(dataProvider: AuthDataProvider())),
          ),
          // You can add more BlocProviders here if needed
        ],
        child: AdminRegistrationPage(),
      ),
    );
  }
}
