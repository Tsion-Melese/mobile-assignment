import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/auth/model/login_model.dart';
import 'package:mobileriverpod/infrastructure/auth/data_provider/login_data_provider.dart';
import 'package:mobileriverpod/infrastructure/auth/repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAuthDataProvider extends Mock implements AuthDataProvider {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('AuthRepository', () {
    test('login - successful login', () async {
      // Arrange
      final mockDataProvider = MockAuthDataProvider();
      final mockSharedPreferences = MockSharedPreferences();
      final expectedToken = 'valid_token';
      final expectedUserId = 123;

      when(() =>
              mockDataProvider.login('test@example.com', 'password', Role.USER))
          .thenAnswer((_) async => {
                'token': expectedToken,
                'userId': expectedUserId,
              });

      when(() => mockSharedPreferences.setString('token', expectedToken))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.setInt('userId', expectedUserId))
          .thenAnswer((_) async => true);

      final repository =
          AuthRepository(mockDataProvider, mockSharedPreferences);

      // Act
      final loginData =
          await repository.login('test@example.com', 'password', Role.USER);

      // Assert
    });

    test('login - failed login', () async {
      // Arrange
      final mockDataProvider = MockAuthDataProvider();
      final mockSharedPreferences = MockSharedPreferences();
      final repository =
          AuthRepository(mockDataProvider, mockSharedPreferences);

      // Act
      final result =
          await repository.login('test@example.com', 'password', Role.USER);

      // Assert
      expect(result, false); // Expecting false when login fails
    });
  });
}
