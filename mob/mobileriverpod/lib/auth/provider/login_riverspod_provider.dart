import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/auth/repostory/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileriverpod/auth/data_provider/login_data_provider.dart'; // Import the AuthRepository class

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance(); // Obtain SharedPreferences instance
});

final authDataProviderProvider = Provider<AuthDataProvider>((ref) {
  final dio = Dio(); // Initialize Dio instance
  return AuthDataProvider(dio);
});

late AuthRepository _authRepository;

final authRepositoryProvider = FutureProvider<AuthRepository>((ref) async {
  final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
  final authDataProvider = ref.read(authDataProviderProvider);
  return AuthRepository(authDataProvider, sharedPreferences);
});
