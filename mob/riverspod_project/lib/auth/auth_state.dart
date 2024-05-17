import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthState {
  AuthInitial,
  AuthLoading,
  AuthAuthenticated,
  AuthError,
}

class RegistrationData {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;

  RegistrationData({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
  });
}

class AuthData {
  final AuthState state;
  final RegistrationData? user;
  final String? error;

  AuthData({
    required this.state,
    this.user,
    this.error,
  });
}

final authStateProvider = StateProvider<AuthData>(
  (ref) => AuthData(state: AuthState.AuthInitial),
);
