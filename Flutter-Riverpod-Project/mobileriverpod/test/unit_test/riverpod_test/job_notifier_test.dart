import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/application/job/provider/job-riverpod_provider.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';
import 'package:mobileriverpod/infrastructure/job/data_provider/job_data_provider.dart';
import 'package:mobileriverpod/infrastructure/job/repository/job_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart'; // Make sure to import Riverpod

// Mocking SharedPreferences for testing purposes
class MockSharedPreferences extends Mock implements SharedPreferences {}

// Mocking Dio for testing purposes
class MockDio extends Mock implements Dio {}

void main() {
  group('Job Riverpod Provider Tests', () {
    late MockSharedPreferences mockSharedPreferences;
    late MockDio mockDio;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      mockDio = MockDio();
    });

    test('JobDataProviderProvider test', () async {
      // Mock behavior for SharedPreferences
      when(mockSharedPreferences.getString('token')).thenReturn('mocked_token');

      // Override JobDataProviderProvider with a mock implementation
      final container = ProviderContainer(overrides: [
        jobDataProviderProvider.overrideWithProvider(
          Provider((ref) => MockJobDataProvider(mockDio, mockSharedPreferences)),
        ),
      ]);

      final jobDataProvider = container.read(jobDataProviderProvider);

      expect(jobDataProvider, isA<MockJobDataProvider>());

      // Test more scenarios as needed for JobDataProviderProvider
    });

    test('JobNotifier test', () async {
      final mockJobRepository = MockJobRepository();
      final container = ProviderContainer(overrides: [
        jobRepositoryProvider.overrideWithProvider(
          Provider((ref) => mockJobRepository),
        ),
      ]);

      final jobNotifier = container.read(jobNotifierProvider.notifier);

      // Test state changes and functionality of JobNotifier
    });

    test('EmplJobNotifier test', () async {
      final mockJobRepository = MockJobRepository();
      final container = ProviderContainer(overrides: [
        jobRepositoryProvider.overrideWithProvider(
          Provider((ref) => mockJobRepository),
        ),
      ]);

      final emplJobNotifier = container.read(EmployeejobNotifierProvider.notifier);

      // Test state changes and functionality of EmplJobNotifier
    });

    test('UserJobNotifier test', () async {
      final mockJobRepository = MockJobRepository();
      final mockUserId = 123; // Mocked user ID
      final container = ProviderContainer(overrides: [
        jobRepositoryProvider.overrideWithProvider(
          Provider((ref) => mockJobRepository),
        ),
        userIdProvider.overrideWithValue(mockUserId),
      ]);

      final userJobNotifier = container.read(userJobNotifierProvider.notifier);

      // Test state changes and functionality of UserJobNotifier
    });

    test('UpdateJobNotifier test', () async {
      final mockJobRepository = MockJobRepository();
      final container = ProviderContainer(overrides: [
        jobRepositoryProvider.overrideWithProvider(
          Provider((ref) => mockJobRepository),
        ),
      ]);

      final updateJobNotifier = container.read(updateJobNotifierProvider.notifier);

      // Test state changes and functionality of UpdateJobNotifier
    });
  });
}

// Mock JobDataProvider for testing purposes
class MockJobDataProvider extends JobDataProvider {
  MockJobDataProvider(Dio dio, SharedPreferences sharedPreferences) : super(dio, sharedPreferences);

  @override
  Future<Map<String, String>> _authenticatedHeaders() async {
    return {'Authorization': 'Bearer mocked_token', 'Content-Type': 'application/json'};
  }

  // Override other methods as needed for testing
}

// Mock JobRepository for testing purposes
class MockJobRepository extends Mock implements JobRepository {}
