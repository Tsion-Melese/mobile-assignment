import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryfront/auth/model/auth_model.dart';
import 'package:tryfront/auth/repos/user_credential.dart';

class AuthDataProvider {
  final Dio _dio; // Use late for later initialization

  AuthDataProvider({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Map<String, dynamic>> registerUser(User user) async {
    try {
      final response = await _dio.post('/auth/register', data: user.toJson());
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
