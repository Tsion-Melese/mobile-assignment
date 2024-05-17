import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverspod_project/auth/data_provider.dart';
import 'package:riverspod_project/auth/registration_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataProvider =
      ref.read(authDataProviderProvider); // Read AuthDataProvider
  return AuthRepository(dataProvider: authDataProvider);
});

class AuthRepository {
  final AuthDataProvider _dataProvider;

  AuthRepository({required AuthDataProvider dataProvider})
      : _dataProvider = dataProvider;

  Future<Map<String, dynamic>> register(
      RegistrationData registrationData) async {
    try {
      final registeredDataJson =
          await _dataProvider.registerUser(registrationData);
      // Check if registeredDataJson is not null or empty to confirm a successful registration
      if (registeredDataJson != null && registeredDataJson.isNotEmpty) {
        // Registration successful, return the registered data
        print('User registered successfully: $registeredDataJson');
        return registeredDataJson;
      } else {
        // Registration failed, handle the failure
        throw Exception('Registration failed: Empty response from server');
      }
    } catch (error) {
      // Handle other errors
      throw Exception('Registration failed: $error');
    }
  }
}
