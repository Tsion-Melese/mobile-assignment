import 'package:equatable/equatable.dart';
import 'package:tryfront/auth/model/loginmodel.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginData data;

  const LoginSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError(this.errorMessage);
}
