import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobileriverpod/domain/user/model/user_model.dart';
import 'package:mobileriverpod/domain/user/model/update_user_model.dart';
import 'package:mobileriverpod/infrastructure/user/data_provider/user_data_provider.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_notifier_test.mocks.dart';

@GenerateMocks([UserDataProvider, SharedPreferences])
void main() {
  late MockUserDataProvider mockUserDataProvider;
  late MockSharedPreferences mockSharedPreferences;
  late UserNotifier userNotifier;
  late int userId;

  setUp(() {
    mockUserDataProvider = MockUserDataProvider();
    mockSharedPreferences = MockSharedPreferences();
    userId = 1; // Example userId
    when(mockSharedPreferences.getInt('userId')).thenReturn(userId);
    when(mockSharedPreferences.getString('token')).thenReturn('test_token');

    // Initialize UserNotifier with mocks
    userNotifier = UserNotifier(mockUserDataProvider, userId);
  });

  test('fetchUserProfile successfully fetches user profile', () async {
    final userProfile = UserProfile(
      userId: 1,
      username: 'testuser',
      email: 'test@example.com',
      firstname: 'Test',
      lastname: 'User',
    );

    // Mock getProfile method to return userProfile
    when(mockUserDataProvider.getProfile()).thenAnswer((_) async => userProfile);

    // Call fetchUserProfile method
    await userNotifier.fetchUserProfile();

    // Verify that state is updated with userProfile
    expect(userNotifier.state, equals(userProfile));
  });

  test('fetchUserProfile handles error', () async {
    // Mock getProfile method to throw an exception
    when(mockUserDataProvider.getProfile()).thenThrow(Exception('Failed to fetch user profile'));

    // Call fetchUserProfile method
    await userNotifier.fetchUserProfile();

    // Verify that state is updated with default values or appropriately handled
    expect(userNotifier.state, isNotNull);
    expect(userNotifier.state!.userId, equals(0));
    expect(userNotifier.state!.username, isEmpty);
    expect(userNotifier.state!.email, isEmpty);
  });

  test('getAllUsers fetches all users', () async {
    final users = [
      UserProfile(
        userId: 1,
        username: 'user1',
        email: 'user1@example.com',
        firstname: 'User1',
        lastname: 'One',
      ),
      UserProfile(
        userId: 2,
        username: 'user2',
        email: 'user2@example.com',
        firstname: 'User2',
        lastname: 'Two',
      ),
    ];

    // Mock getAllUsers method
    when(mockUserDataProvider.getAllUsers()).thenAnswer((_) async => users);

    // Call getAllUsers method
    final fetchedUsers = await userNotifier.getAllUsers();

    // Verify that fetchedUsers matches the expected users list
    expect(fetchedUsers, equals(users));
  });
}
