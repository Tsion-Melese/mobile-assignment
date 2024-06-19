import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/auth/model/login_model.dart';
import 'package:mobileriverpod/domain/user/model/user_model.dart';

void main() {
  group('UserProfile Model', () {
    test('should instantiate correctly with required fields', () {
      // Arrange
      final userProfile = UserProfile(
        userId: 1,
        username: 'john_doe',
        email: 'john.doe@example.com',
        firstname: 'John',
        lastname: 'Doe',
        userRole: Role.USER,
      );

      // Assert
      expect(userProfile.userId, 1);
      expect(userProfile.username, 'john_doe');
      expect(userProfile.email, 'john.doe@example.com');
      expect(userProfile.firstname, 'John');
      expect(userProfile.lastname, 'Doe');
      expect(userProfile.userRole, Role.USER);
    });

    test('Equatable should correctly compare two identical objects', () {
      // Arrange
      final userProfile1 = UserProfile(
        userId: 1,
        username: 'john_doe',
        email: 'john.doe@example.com',
        firstname: 'John',
        lastname: 'Doe',
        userRole: Role.USER,
      );

      final userProfile2 = UserProfile(
        userId: 1,
        username: 'john_doe',
        email: 'john.doe@example.com',
        firstname: 'John',
        lastname: 'Doe',
        userRole: Role.USER,
      );

      // Assert
      expect(userProfile1 == userProfile2, true);
    });

    test('Equatable should correctly identify two different objects', () {
      // Arrange
      final userProfile1 = UserProfile(
        userId: 1,
        username: 'john_doe',
        email: 'john.doe@example.com',
        firstname: 'John',
        lastname: 'Doe',
        userRole: Role.USER,
      );

      final userProfile2 = UserProfile(
        userId: 2,
        username: 'jane_doe',
        email: 'jane.doe@example.com',
        firstname: 'Jane',
        lastname: 'Doe',
        userRole: Role.ADMIN,
      );

      // Assert
      expect(userProfile1 == userProfile2, false);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final userProfile = UserProfile(
        userId: 1,
        username: 'john_doe',
        email: 'john.doe@example.com',
        firstname: 'John',
        lastname: 'Doe',
        userRole: Role.USER,
      );
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'userId': 1,
        'username': 'john_doe',
        'email': 'john.doe@example.com',
        'firstname': 'John',
        'lastname': 'Doe',
        'userRole': 'USER',
      };
    });
  });
}
