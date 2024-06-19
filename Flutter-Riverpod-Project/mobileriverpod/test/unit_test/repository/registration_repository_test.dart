import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/infrastructure/auth/repository/registration_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobileriverpod/infrastructure/auth/data_provider/registration_data_provider.dart';
import 'package:mobileriverpod/domain/auth/model/registration_model.dart';

// Generate a MockAuthDataProvider
@GenerateMocks([AuthDataProvider])
import 'registration_repository_test.mocks.dart';

void main() {
  late MockAuthDataProvider mockAuthDataProvider;
  late AuthRepository authRepository;

  setUp(() {
    mockAuthDataProvider = MockAuthDataProvider();
    authRepository = AuthRepository(dataProvider: mockAuthDataProvider);
  });

  group('AuthRepository', () {
    final registrationData = RegistrationData(
      email: 'test@example.com',
      password: 'password',
      username: 'testuser',
      firstName: 'Test',
      lastName: 'User',
      role: Role.USER,
    );

    final registrationDataJson = {
      'email': 'test@example.com',
      'password': 'password',
      'username': 'testuser',
      'firstName': 'Test',
      'lastName': 'User',
      'role': 'USER',
    };

    test('register returns RegistrationData on successful registration', () async {
      // Arrange
      when(mockAuthDataProvider.registerUser(any))
          .thenAnswer((_) async => registrationDataJson);

      // Act
      final result = await authRepository.register(registrationData);

      // Assert
      expect(result.email, registrationData.email);
      expect(result.username, registrationData.username);
      verify(mockAuthDataProvider.registerUser(any)).called(1);
    });

    test('register throws an exception on failed registration', () async {
      // Arrange
      when(mockAuthDataProvider.registerUser(any))
          .thenThrow(Exception('Failed to register'));

      // Act & Assert
      expect(() async => await authRepository.register(registrationData), throwsException);
      verify(mockAuthDataProvider.registerUser(any)).called(1);
    });
  });
}
