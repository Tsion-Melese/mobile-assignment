// auth_event.dart
import 'package:equatable/equatable.dart';
import 'package:tryfront/auth/model/auth_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String password; // Only include during registration

  const RegisterEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}

// Define NetworkException
class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

// Define AuthException
class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class LoginEvent extends AuthEvent {
  final User auth;

  const LoginEvent(this.auth);

  @override
  List<Object> get props => [auth];

  @override
  String toString() => 'Auth Created {Auth Id: ${auth.token}';
}

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final String token;

  const LoggedIn({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String username; // Change to username instead of email
  final String password;

  const LoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginRequested { username: $username, password: $password }';
}
