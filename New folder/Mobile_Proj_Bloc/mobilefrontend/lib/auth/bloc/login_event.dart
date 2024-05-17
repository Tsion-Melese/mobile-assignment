import 'package:equatable/equatable.dart';
import 'package:mobilefrontend/auth/model/login_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});
}

class LoginResponseReceived extends LoginEvent {
  final bool success;
  final String? message;
  final LoginData? data;

  const LoginResponseReceived(this.success, this.message, this.data);

  @override
  List<Object?> get props => [success, message, data];
}
