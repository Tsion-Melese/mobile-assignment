import 'package:equatable/equatable.dart';
import 'package:tryfront/auth/model/auth_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];

  static authenticated(User user) {}
}

class AuthInitial extends AuthState {} // Initial state

class AuthLoading extends AuthState {} // Loading state

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Authenticated extends AuthState {
  final String token;

  const Authenticated({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'Authenticated { token: $token }';
}

class AuthUnauthenticated extends AuthState {} // Unauthenticated state

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthDataLoaded extends AuthState {
  final User user;

  const AuthDataLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class AuthDataLoadingError extends AuthState {
  final Object error;
  const AuthDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}

class AppStartedState extends AuthState {}

class LoggedOutState extends AuthState {}

class Unauthenticated extends AuthState {}

class LoginAuthError extends AuthState {
  final String message; // Named parameter for error message

  LoginAuthError({required this.message}); // Constructor with named parameter

  @override
  List<Object> get props => [message]; // Include message in props for Equatable

  @override
  String toString() =>
      'AuthError { message: $message }'; // Override toString for debugging
}
