import 'package:riverspod_project/auth/registration_model.dart';

enum AuthEvent {
  RegisterEvent,
  AdminRegisterEvent, // Add if needed
}

class RegisterEvent {
  final RegistrationData registrationData;

  RegisterEvent(this.registrationData);
}
