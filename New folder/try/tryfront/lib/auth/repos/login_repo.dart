import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryfront/auth/data_provider/login_concarite.dart';
import 'package:tryfront/auth/model/loginmodel.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  final SharedPreferences sharedPreferences;

  AuthRepository(this.dataProvider, this.sharedPreferences);

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
