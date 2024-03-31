import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get username => _prefs.getString('username') ?? '';

  static set username(String value) {
    _prefs.setString('username', value);
  }

  static String get access => _prefs.getString('access') ?? "";

  static set access(String value) {
    _prefs.setString('access', value);
  }

  static String get userId => _prefs.getString('userId') ?? "";

  static set userId(String value) {
    _prefs.setString('userId', value);
  }
}
