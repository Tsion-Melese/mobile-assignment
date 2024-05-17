import 'package:mobilefrontend/auth/data_provider/registration_data_provider.dart';
import 'package:mobilefrontend/auth/model/registration_model.dart';

class AuthRepository {
  final AuthDataProvider _dataProvider;

  AuthRepository({required AuthDataProvider dataProvider})
      : _dataProvider = dataProvider;
  Future<User> register(User user) async {
    try {
      final registeredUserJson = await _dataProvider.registerUser(user);
      final registeredUser = User.fromJson(registeredUserJson);
      return registeredUser;
    } catch (error) {
      throw Exception('Registration failed: $error');
    }
  }
}
