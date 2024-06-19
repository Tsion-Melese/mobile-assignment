import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/infrastructure/user/data_provider/user_data_provider.dart';
import 'package:mobileriverpod/domain/user/model/user_model.dart';
import 'package:mobileriverpod/domain/user/model/update_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userIdProvider = Provider<int>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  // Check if the sharedPreferences is available and has data
  if (sharedPreferences is AsyncData<SharedPreferences>) {
    return sharedPreferences.value.getInt('userId') ?? 0;
  }
  // Return a default value if sharedPreferences is not yet available or has an error
  return 0;
});

final userProvider = StateNotifierProvider<UserNotifier, UserProfile?>((ref) {
  final userId = ref.watch(userIdProvider);
  final sharedPreferences = ref.watch(sharedPreferencesProvider);

  UserDataProvider? dataProvider;
  if (sharedPreferences is AsyncData<SharedPreferences>) {
    dataProvider = UserDataProvider(Dio(), sharedPreferences.value!);
  }

  return UserNotifier(dataProvider!, userId);
});

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

class UserNotifier extends StateNotifier<UserProfile?> {
  final UserDataProvider dataProvider;
  final int userId;

  UserNotifier(this.dataProvider, this.userId) : super(null) {
    // Fetch user profile data only if userId is not 0
    if (userId != 0) {
      fetchUserProfile();
    }
  }

  // Fetch user profile with error handling
  Future<void> fetchUserProfile() async {
    try {
      state = null; // Set state to null to indicate loading
      final userProfile = await dataProvider.getProfile();
      state = userProfile;
    } catch (error) {
      print('Error fetching user profile: $error');
      state = UserProfile(
        userId: 0, // Provide default value for userId or handle it differently
        username: '', // Provide default value for username
        email: '', // Provide default value for email
        firstname: '', // Provide default value for firstname
        lastname: '', // Provide default value for lastname
      );
    }
  }

  void updateUserProfile(UpdateUserDto dto) async {
    try {
      await dataProvider.updateProfile(dto);
      fetchUserProfile();
    } catch (error) {
      print('Error updating user profile: $error');
    }
  }

  void deleteUserProfile() async {
    try {
      await dataProvider.deleteProfile();
      state = null;
    } catch (error) {
      print('Error deleting user profile: $error');
    }
  }

  Future<List<UserProfile>> getAllUsers() async {
    try {
      return await dataProvider.getAllUsers();
    } catch (error) {
      print('Error fetching all users: $error');
      return [];
    }
  }

  Future<void> deleteProfileByUserId(int userId) async {
    try {
      await dataProvider.deleteProfileByUserId(userId);
    } catch (error) {
      print('Error deleting profile for user $userId: $error');
    }
  }
}
