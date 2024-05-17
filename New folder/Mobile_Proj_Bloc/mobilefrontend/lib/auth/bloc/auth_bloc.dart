import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/auth_event.dart';
import 'package:mobilefrontend/auth/bloc/auth_state.dart';
import 'package:mobilefrontend/auth/model/registration_model.dart';
import 'package:mobilefrontend/auth/repository/registration_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository; // Define _authRepository

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    // Register event handlers in the constructor
    on<RegisterEvent>(_onRegisterEvent);
  }

  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final registeredUser = await _authRepository.register(User(
        username: event.username,
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
        password: event.password,
        role: "USER",

        // Only include during registration
      ));
      emit(AuthAuthenticated(
          registeredUser)); // Emit authenticated state with user
    } catch (error) {
      emit(AuthError(error.toString())); // Handle specific errors if needed
    }
  }
}
