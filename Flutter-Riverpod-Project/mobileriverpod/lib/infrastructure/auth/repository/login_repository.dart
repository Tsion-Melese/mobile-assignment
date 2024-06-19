import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileriverpod/infrastructure/auth/data_provider/login_data_provider.dart';
import 'package:mobileriverpod/domain/auth/model/login_model.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  final SharedPreferences sharedPreferences;

  AuthRepository(this.dataProvider, this.sharedPreferences);

  Future<bool> login(String email, String password, Role role) async {
    try {
      final data = await dataProvider.login(email, password, role);
      final token = data['token'];
      final userId = data['userId'];

      await sharedPreferences.setString('token', token);
      await sharedPreferences.setInt('userId', userId);

      // Return true to indicate successful login
      return true;
    } catch (error) {
      // Return false to indicate failed login
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await sharedPreferences.remove('token');
      await sharedPreferences.remove('userId');
    } catch (error) {
      rethrow;
    }
  }
}
