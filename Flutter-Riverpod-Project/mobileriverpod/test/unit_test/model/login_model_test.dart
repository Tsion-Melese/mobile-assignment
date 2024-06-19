import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/auth/model/login_model.dart';

void main() {
  group('LoginData', () {
    test('toJson() should return a valid JSON map', () {
      // Arrange
      final loginData = LoginData(email: 'test@example.com', password: 'password', role: Role.ADMIN);
      
      // Act
      final jsonMap = loginData.toJson();
      
      // Assert
      expect(jsonMap, {
        'email': 'test@example.com',
        'password': 'password',
        'role': 'ADMIN',
      });
    });
    
    test('fromJson() should return a valid LoginData object', () {
      // Arrange
      final loginDataJson = {
        'email': 'test@example.com',
        'password': 'password',
        'role': 'ADMIN',
      };
      
      // Act
      final loginData = LoginData.fromJson(loginDataJson);
      
      // Assert
      expect(loginData.email, 'test@example.com');
      expect(loginData.password, 'password');
      expect(loginData.role, Role.ADMIN);
    });
  });

  group('AuthLoginData', () {
    test('AuthLoginData should contain token and id', () {
      // Arrange
      const token = 'token';
      const id = 123;
      
      // Act
      final authLoginData = AuthLoginData(token: token, id: id);
      
      // Assert
      expect(authLoginData.token, token);
      expect(authLoginData.id, id);
    });
  });
}
