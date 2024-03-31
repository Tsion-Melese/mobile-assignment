import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryfront/auth/bloc/login_event.dart';
import 'package:tryfront/auth/bloc/login_state.dart';
import 'package:tryfront/auth/repos/login_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

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
      // Emit appropriate state based on login response:
      emit(LoginSuccess(loginData));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}
