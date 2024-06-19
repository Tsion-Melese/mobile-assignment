import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/user/model/update_user_model.dart';

void main() {
  group('UpdateUserDto Model', () {
    test('should instantiate correctly with required fields', () {
      // Arrange
      final updateUserDto = UpdateUserDto(
        username: 'john_doe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      // Assert
      expect(updateUserDto.username, 'john_doe');
      expect(updateUserDto.email, 'john.doe@example.com');
      expect(updateUserDto.firstName, 'John');
      expect(updateUserDto.lastName, 'Doe');
    });

    test('props list should return correct properties', () {
      // Arrange
      final updateUserDto = UpdateUserDto(
        username: 'john_doe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      // Assert
      expect(updateUserDto.props, ['john_doe', 'john.doe@example.com', 'John', 'Doe']);
    });

    test('toJson method should convert object to JSON map', () {
      // Arrange
      final updateUserDto = UpdateUserDto(
        username: 'john_doe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      // Act
      final json = updateUserDto.toJson();

      // Assert
      expect(json, {
        'email': 'john.doe@example.com',
        'username': 'john_doe',
        'firstName': 'John',
        'lastName': 'Doe',
      });
    });
  });
}
