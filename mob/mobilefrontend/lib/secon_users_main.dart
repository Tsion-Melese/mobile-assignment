import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/login_bloc.dart';
import 'package:mobilefrontend/auth/data_provider/login_data_providerl.dart';
import 'package:mobilefrontend/auth/repository/login_repo.dart';
import 'package:mobilefrontend/auth/view/admin_login_page.dart';
import 'package:mobilefrontend/auth/view/login_page.dart';
import 'package:mobilefrontend/user/view/user_profile.dart'; // Import UserProfilePage
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio(); // Instantiate Dio
  final sharedPreferences =
      await SharedPreferences.getInstance(); // Instantiate SharedPreferences
  final authDataProvider =
      AuthDataProvider(dio); // Instantiate AuthDataProvider
  final authRepository = AuthRepository(
      authDataProvider, sharedPreferences); // Instantiate AuthRepository
  runApp(MyApp(authRepository: authRepository)); // Pass authRepository to MyApp
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository; // Declare authRepository

  const MyApp({Key? key, required this.authRepository})
      : super(key: key); // Receive authRepository

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dmo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(authRepository),
              child:
                  AdminLoginPage(), // Assuming LoginPage is your login page widget
            ),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
