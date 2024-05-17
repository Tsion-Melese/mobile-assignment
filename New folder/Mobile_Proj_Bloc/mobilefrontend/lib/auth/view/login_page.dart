import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/login_bloc.dart';
import 'package:mobilefrontend/auth/bloc/login_event.dart';
import 'package:mobilefrontend/auth/bloc/login_state.dart';
import 'package:mobilefrontend/auth/data_provider/login_data_provider.dart';
import 'package:mobilefrontend/auth/repository/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
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
                LoginAuthRepository(
                  LoginDataProvider(Dio()), // Initialize with Dio instance
                  sharedPreferences, // Use SharedPreferences instance from FutureBuilder
                ),
              ),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    // Navigate to the next screen or perform any other action on successful login
                    // You may want to store the token here
                    // Example: Navigator.pushNamed(context, '/home');
                    Navigator.pushReplacementNamed(context, '/employerjob');
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
                  usernameController: _usernameController,
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
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginForm({
    Key? key,
    required this.usernameController,
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
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
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
                LoginRequested(
                  username: usernameController.text,
                  password: passwordController.text,
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
