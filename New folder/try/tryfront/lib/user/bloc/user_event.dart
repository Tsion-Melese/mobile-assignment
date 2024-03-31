import 'package:equatable/equatable.dart';
import 'package:tryfront/user/model/updateuser_model.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserProfile extends UserProfileEvent {
  const LoadUserProfile();
}

class UpdateUserProfile extends UserProfileEvent {
  final UpdateUserDto updateDto;

  const UpdateUserProfile(this.updateDto);

  @override
  List<Object?> get props => [updateDto];
}

class DeleteUserProfile extends UserProfileEvent {
  const DeleteUserProfile();
}
