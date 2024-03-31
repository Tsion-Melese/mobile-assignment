import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryfront/auth/bloc/auth_event.dart';
import 'package:tryfront/auth/bloc/auth_state.dart';
import 'package:tryfront/auth/repos/auth_repo.dart'; // Import AuthRepository
import 'package:tryfront/auth/model/auth_model.dart';

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
        password: event.password, // Only include during registration
      ));
      emit(AuthAuthenticated(
          registeredUser)); // Emit authenticated state with user
    } catch (error) {
      emit(AuthError(error.toString())); // Handle specific errors if needed
    }
  }
}
