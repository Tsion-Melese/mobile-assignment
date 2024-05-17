import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/login_bloc.dart';
import 'package:mobilefrontend/auth/bloc/login_event.dart';
import 'package:mobilefrontend/auth/bloc/login_state.dart';
import 'package:mobilefrontend/auth/data_provider/login_data_providerl.dart';
import 'package:mobilefrontend/auth/model/login_model.dart';
import 'package:mobilefrontend/auth/repository/login_repo.dart';
import 'package:mobilefrontend/user/view/admin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final sharedPreferences = snapshot.data!;
            return BlocProvider(
              create: (context) => LoginBloc(
                AuthRepository(
                  AuthDataProvider(Dio()), // Initialize with Dio instance
                  sharedPreferences, // Use SharedPreferences instance from FutureBuilder
                ),
              ),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    // Navigate to the next screen or perform any other action on successful login
                    // You may want to store the token here
                    // Example: Navigator.pushNamed(context, '/home');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminProfilePage()));
                  } else if (state is LoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: LoginForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
              ),
            ); // Added closing parenthesis here
          } else {
            // Handle loading state
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'email',
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(
                AdminLoginRequested(
                  email: emailController.text,
                  password: passwordController.text,
                  role: Role.ADMIN,
                ),
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
