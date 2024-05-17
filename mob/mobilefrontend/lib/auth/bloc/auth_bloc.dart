import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/auth_event.dart';
import 'package:mobilefrontend/auth/bloc/auth_state.dart';
import 'package:mobilefrontend/auth/model/registration_model.dart';
import 'package:mobilefrontend/auth/repository/registration_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<RegisterEvent>(_onRegisterEvent);
    on<AdminRegisterEvent>(_onAdminRegisterEvent);
  }

  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final registeredUser = await _authRepository.register(RegistrationData(
        email: event.email,
        password: event.password,
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
        role: Role.USER,
      ));
      emit(AuthAuthenticated(registeredUser));
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }

  Future<void> _onAdminRegisterEvent(
    AdminRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final registeredAdmin = await _authRepository.register(RegistrationData(
        email: event.email,
        password: event.password,
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
        role: Role.ADMIN,
      ));
      emit(AuthAuthenticated(registeredAdmin));
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}