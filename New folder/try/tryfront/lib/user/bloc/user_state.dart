import 'package:equatable/equatable.dart';
import 'package:tryfront/user/model/user_model.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileLoaded(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class UserProfileUpdateSuccess extends UserProfileState {
  const UserProfileUpdateSuccess();
}

class UserProfileUpdateFailure extends UserProfileState {
  final String error;

  const UserProfileUpdateFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UserProfileDeleteSuccess extends UserProfileState {
  const UserProfileDeleteSuccess();
}

class UserProfileDeleteFailure extends UserProfileState {
  final String error;

  const UserProfileDeleteFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UserProfileError extends UserProfileState {
  final String error;

  const UserProfileError(this.error);

  @override
  List<Object?> get props => [error];
}
