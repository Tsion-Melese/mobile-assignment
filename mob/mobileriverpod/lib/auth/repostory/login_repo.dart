import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileriverpod/auth/data_provider/login_data_provider.dart';
import 'package:mobileriverpod/auth/model/login_model.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  final SharedPreferences sharedPreferences;

  AuthRepository(this.dataProvider, this.sharedPreferences);

  Future<void> login(String email, String password, Role role) async {
    try {
      final data = await dataProvider.login(email, password, role);
      final token = data['token'];
      final userId = data['userId'];

      await sharedPreferences.setString('token', token);
      await sharedPreferences.setInt('userId', userId);
    } catch (error) {
      rethrow;
    }
  }
}
