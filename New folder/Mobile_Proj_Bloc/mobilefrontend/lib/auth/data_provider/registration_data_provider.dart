import 'package:dio/dio.dart';
import 'package:mobilefrontend/auth/model/registration_model.dart';

class AuthDataProvider {
  final Dio _dio; // Use late for later initialization

  AuthDataProvider({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Map<String, dynamic>> registerUser(User user) async {
    try {
      final response = await _dio.post('/auth/signup', data: user.toJson());
      if (response.statusCode == 200) {
        return response.data; // Return the JSON response directly
      } else {
        throw Exception(
            'Registration failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow; // Rethrow the exception
    }
  }
}
