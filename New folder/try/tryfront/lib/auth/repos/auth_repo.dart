import 'package:tryfront/auth/data_provider/auth_data_provider.dart';
import 'package:tryfront/auth/model/auth_model.dart';
import 'package:tryfront/auth/repos/user_credential.dart';

class AuthRepository {
  final AuthDataProvider _dataProvider;

  AuthRepository({required AuthDataProvider dataProvider})
      : _dataProvider = dataProvider;
// AuthRepository
  Future<User> register(User user) async {
    try {
      final registeredUserJson = await _dataProvider.registerUser(user);
      final registeredUser = User.fromJson(registeredUserJson);
      return registeredUser;
    } catch (error) {
      throw Exception('Registration failed: $error');
    }
  }

  // Logout method
}
