import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/auth/model/registration_model.dart';

void main() {
  group('RegistrationData', () {
    test('toJson() should return a valid JSON map', () {
      // Arrange
      final registrationData = RegistrationData(
        email: 'test@example.com',
        password: 'password',
        username: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        role: Role.ADMIN,
      );

      // Act
      final jsonMap = registrationData.toJson();

      // Assert
      expect(jsonMap, {
        'email': 'test@example.com',
        'password': 'password',
        'username': 'testuser',
        'firstName': 'Test',
        'lastName': 'User',
        'role': 'ADMIN',
      });
    });

    test('fromJson() should return a valid RegistrationData object', () {
      // Arrange
      final registrationDataJson = {
        'email': 'test@example.com',
        'password': 'password',
        'username': 'testuser',
        'firstName': 'Test',
        'lastName': 'User',
        'role': 'ADMIN',
      };

      // Act
      final registrationData = RegistrationData.fromJson(registrationDataJson);

      // Assert
      expect(registrationData.email, 'test@example.com');
      expect(registrationData.password, 'password');
      expect(registrationData.username, 'testuser');
      expect(registrationData.firstName, 'Test');
      expect(registrationData.lastName, 'User');
      expect(registrationData.role, Role.ADMIN);
    });

    test('fromJson() should handle null values gracefully', () {
      // Arrange
      final registrationDataJson = {
        'email': null,
        'password': null,
        'username': null,
        'firstName': null,
        'lastName': null,
        'role': null,
      };

      // Act
      final registrationData = RegistrationData.fromJson(registrationDataJson);

      // Assert
      expect(registrationData.email, '');
      expect(registrationData.password, '');
      expect(registrationData.username, '');
      expect(registrationData.firstName, '');
      expect(registrationData.lastName, '');
      expect(registrationData.role, Role.USER);
    });

    test('factory empty() should return an empty RegistrationData object', () {
      // Act
      final registrationData = RegistrationData.empty();

      // Assert
      expect(registrationData.email, '');
      expect(registrationData.password, '');
      expect(registrationData.username, '');
      expect(registrationData.firstName, '');
      expect(registrationData.lastName, '');
      expect(registrationData.role, Role.USER);
    });
  });
}
