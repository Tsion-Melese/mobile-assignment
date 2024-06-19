import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/user/model/user_model.dart';
import 'package:mobileriverpod/infrastructure/user/data_provider/user_data_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('UserDataProvider', () {
    late MockDio mockDio;
    late MockSharedPreferences mockSharedPreferences;
    late UserDataProvider dataProvider;

    setUp(() {
      mockDio = MockDio();
      mockSharedPreferences = MockSharedPreferences();
      dataProvider = UserDataProvider(mockDio, mockSharedPreferences);
    });

    test('getProfile - success', () async {
      // Arrange
      when(() => mockSharedPreferences.getString('token'))
          .thenReturn('dummy_token');
      when(() => mockSharedPreferences.getInt('userId')).thenReturn(123);
      when(() => mockDio.get(any(), options: any(named: 'options')))
          .thenAnswer((_) async => Response<dynamic>(
                requestOptions: RequestOptions(path: 'dummy_path'),
                data: {
                  'userId': 123,
                  'username': 'testuser',
                  'email': 'test@example.com',
                  'firstName': 'Test',
                  'lastName': 'User',
                },
                statusCode: 200,
              ));

      // Act
      final result = await dataProvider.getProfile();

      // Assert
      expect(
          result,
          UserProfile(
            userId: 123,
            username: 'testuser',
            email: 'test@example.com',
            firstname: 'Test',
            lastname: 'User',
          ));
    });

    test('deleteProfile - success', () async {
      // Arrange
      when(() => mockSharedPreferences.getString('token'))
          .thenReturn('dummy_token');
      when(() => mockSharedPreferences.getInt('userId')).thenReturn(123);
      when(() => mockSharedPreferences.clear()).thenAnswer((_) async => true);
      when(() => mockDio.delete(any(), options: any(named: 'options')))
          .thenAnswer((_) async => Response<dynamic>(
                requestOptions: RequestOptions(path: 'dummy_path'),
                statusCode: 200,
              ));

      // Act
      await dataProvider.deleteProfile();

      // Assert
      verify(() => mockSharedPreferences.clear()).called(1);
    });

    // Add more tests for other methods similarly
  });
}
