import 'package:tryfront/user/data_provider/user_data.dart';
import 'package:tryfront/user/model/user_model.dart';
import 'package:tryfront/user/model/updateuser_model.dart';

abstract class UserRepository {
  Future<UserProfile?> getProfile();
  Future<void> updateProfile(UpdateUserDto dto);
  Future<void> deleteProfile();
}

class ConcreteUserRepository implements UserRepository {
  final UserDataProvider dataProvider;

  ConcreteUserRepository(this.dataProvider);

  @override
  Future<UserProfile?> getProfile() async {
    return dataProvider.getProfile();
  }

  @override
  Future<void> updateProfile(UpdateUserDto dto) async {
    return dataProvider.updateProfile(dto);
  }

  @override
  Future<void> deleteProfile() async {
    return dataProvider.deleteProfile();
  }
}
