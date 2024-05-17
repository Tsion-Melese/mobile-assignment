import 'package:mobilefrontend/auth/data_provider/login_data_provider.dart';
import 'package:mobilefrontend/auth/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuthRepository {
  final LoginDataProvider dataProvider;
  final SharedPreferences sharedPreferences;

  LoginAuthRepository(this.dataProvider, this.sharedPreferences);

  Future<LoginData> login(String username, String password) async {
    try {
      final data = await dataProvider.login(username, password);
      final token = data['token'];
      final userId = data['userId'];
      await sharedPreferences.setString('token', token);
      await sharedPreferences.setString('userId', userId);
      return LoginData(token: token, userId: userId);
    } catch (error) {
      rethrow;
    }
  }
}
