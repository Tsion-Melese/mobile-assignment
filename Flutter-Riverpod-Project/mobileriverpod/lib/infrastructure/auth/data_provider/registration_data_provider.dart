import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileriverpod/constand.dart';
import 'package:mobileriverpod/domain/auth/model/registration_model.dart';

class AuthDataProvider {
  late http.Client client;

  AuthDataProvider({http.Client? httpClient}) {
    client = httpClient ?? http.Client();
  }

  Future<Map<String, dynamic>> registerUser(RegistrationData user) async {
    try {
      final response = await client.post(
        Uri.parse('$x/auth/signup'),
        body: json.encode(user.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
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
