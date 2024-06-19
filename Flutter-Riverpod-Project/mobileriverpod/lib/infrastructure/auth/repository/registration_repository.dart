import 'package:mobileriverpod/infrastructure/auth/data_provider/registration_data_provider.dart';
import 'package:mobileriverpod/domain/auth/model/registration_model.dart';

class AuthRepository {
  final AuthDataProvider _dataProvider;

  AuthRepository({required AuthDataProvider dataProvider})
      : _dataProvider = dataProvider;
  Future<RegistrationData> register(RegistrationData registrationData) async {
    try {
      final registeredDataJson =
          await _dataProvider.registerUser(registrationData);
      print("Response from server: $registeredDataJson"); // Log the response

      // Check if the registration data is not null
      if (registeredDataJson != null) {
        // Assuming the presence of an access token indicates successful registration
        final registeredData = RegistrationData.fromJson(registeredDataJson);
        return registeredData;
      } else {
        // Handle unexpected response
        throw Exception(
            'Registration failed with unexpected response: $registeredDataJson');
      }
    } catch (error) {
      print("Registration Error: $error");
      throw Exception('Registration failed: $error');
    }
  }
}
