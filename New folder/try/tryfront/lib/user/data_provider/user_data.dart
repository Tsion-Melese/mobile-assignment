import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryfront/user/model/user_model.dart';
import 'package:tryfront/user/model/updateuser_model.dart';

class UserDataProvider {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  UserDataProvider(this.dio, this.sharedPreferences);

  Future<Map<String, dynamic>> _authenticatedRequest() async {
    final token = sharedPreferences.getString('token');
    final userId = sharedPreferences.getString('userId');

    if (token == null || userId == null) {
      throw Exception('Missing token or user ID in local storage.');
    }

    return {
      'userId': userId,
      'token': token,
    };
  }

  Future<UserProfile?> getProfile() async {
    try {
      final authData = await _authenticatedRequest();

      final response = await dio.get(
          'http://localhost:3000/users/${authData['userId']}/profile',
          options: Options(
              headers: {'Authorization': 'Bearer ${authData['token']}'}));

      if (response.statusCode == 200) {
        final data = response.data;
        return UserProfile(
          userId: authData['userId'],
          username: data['username'] as String,
          email: data['email'] as String,
        );
      } else {
        throw Exception(
            'Failed to fetch profile data. Status code: ${response.statusCode}');
      }
    } on DioError catch (error) {
      rethrow;
    } catch (error) {
      throw Exception('An error occurred while fetching profile data.');
    }
  }

  Future<void> updateProfile(UpdateUserDto dto) async {
    try {
      final authData = await _authenticatedRequest();

      final response = await dio.patch(
        'http://localhost:3000/users/${authData['userId']}',
        options:
            Options(headers: {'Authorization': 'Bearer ${authData['token']}'}),
        data: dto.toJson(),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully.');
      } else {
        throw Exception(
            'Failed to update profile. Status code: ${response.statusCode}');
      }
    } on DioError catch (error) {
      rethrow;
    } catch (error) {
      throw Exception('An error occurred while updating profile.');
    }
  }

  Future<void> deleteProfile() async {
    try {
      final authData = await _authenticatedRequest();

      final response = await dio.delete(
          'http://localhost:3000/users/${authData['userId']}',
          options: Options(
              headers: {'Authorization': 'Bearer ${authData['token']}'}));

      if (response.statusCode == 200) {
        await sharedPreferences.clear();
        print('Profile deleted successfully.');
      } else {
        throw Exception(
            'Failed to delete profile. Status code: ${response.statusCode}');
      }
    } on DioError catch (error) {
      rethrow;
    } catch (error) {
      throw Exception('An error occurred while deleting profile.');
    }
  }
}
