import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/login_event.dart';
import 'package:mobilefrontend/auth/bloc/login_state.dart';
import 'package:mobilefrontend/auth/repository/login_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginAuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async => await _login(event, emit));
    on<LoginResponseReceived>((event, emit) => emit(event.success
        ? LoginSuccess(event.data!)
        : LoginError(event.message!)));
  }

  Future<void> _login(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final loginData =
          await authRepository.login(event.username, event.password);
      emit(LoginSuccess(loginData));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}
