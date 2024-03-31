import 'package:dio/dio.dart';

class AuthDataProvider {
  final Dio dio;

  AuthDataProvider(this.dio);

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await dio.post(
        'http://localhost:3000/auth/login',
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }
}
