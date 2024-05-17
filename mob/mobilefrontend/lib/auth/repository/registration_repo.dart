import 'package:mobilefrontend/auth/data_provider/registration_data_provider.dart';
import 'package:mobilefrontend/auth/model/registration_model.dart';

class AuthRepository {
  final AuthDataProvider _dataProvider;

  AuthRepository({required AuthDataProvider dataProvider})
      : _dataProvider = dataProvider;

  Future<RegistrationData> register(RegistrationData registrationData) async {
    try {
      final registeredDataJson =
          await _dataProvider.registerUser(registrationData);
      final registeredData = RegistrationData.fromJson(registeredDataJson);
      return registeredData;
    } catch (error) {
      throw Exception('Registration failed: $error');
    }
  }
}
