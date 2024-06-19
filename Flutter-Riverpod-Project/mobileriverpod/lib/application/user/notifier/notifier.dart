import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/domain/user/model/user_model.dart';

class UserNotifier extends StateNotifier<UserProfile?> {
  UserNotifier(UserProfile? state) : super(state);

  void updateUser(UserProfile? profile) {
    state = profile;
  }

  void deleteUser() {
    state = null;
  }

  void createUser(UserProfile profile) {
    state = profile;
  }

  void readUser(UserProfile profile) {
    state = profile;
  }
}
