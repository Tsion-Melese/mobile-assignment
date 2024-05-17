import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tryfront/auth/model/auth_model.dart';

class AuthDataProvider {
  final String baseUrl;

  AuthDataProvider({required this.baseUrl});

  Future<Map<String, dynamic>> registerUser(User user) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/auth/register'),
          body: json.encode(user.toJson()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Registration failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow; // Rethrow the exception
    }
  }
}
