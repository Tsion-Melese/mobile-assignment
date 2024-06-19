import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mobileriverpod/domain/auth/model/registration_model.dart';
import 'package:mobileriverpod/infrastructure/auth/data_provider/registration_data_provider.dart';

void main() {
  group('AuthDataProvider', () {
    test('registerUser returns registration data on successful registration', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        final mapJson = {'access_token': 'dummy_token'};
        return http.Response(json.encode(mapJson), 201, headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
      });

      final dataProvider = AuthDataProvider(httpClient: mockClient);

      final registrationData = RegistrationData(
        email: 'test@example.com',
        password: 'testpassword',
        username: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        role: Role.user,
      );

      // Act
      final result = await dataProvider.registerUser(registrationData);

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['access_token'], 'dummy_token');
    });

    test('registerUser throws exception on non-201 status code', () async {
      // Arrange
      final mockClient = MockClient((request) async {
        return http.Response('Unauthorized', 401);
      });

      final dataProvider = AuthDataProvider(httpClient: mockClient);

      final registrationData = RegistrationData(
        email: 'test@example.com',
        password: 'testpassword',
        username: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        role: Role.user,
      );

      // Act & Assert
      expect(
        () async => await dataProvider.registerUser(registrationData),
        throwsException,
      );
    });
  });
}
