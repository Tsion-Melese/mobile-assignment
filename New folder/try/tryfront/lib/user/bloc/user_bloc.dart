import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryfront/user/bloc/user_event.dart';
import 'package:tryfront/user/bloc/user_state.dart';
import 'package:tryfront/user/data_provider/user_data.dart';
import 'package:tryfront/user/repo/user_repo.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository userRepository;

  UserProfileBloc(this.userRepository) : super(UserProfileInitial()) {
    on<LoadUserProfile>((event, emit) async {
      try {
        emit(UserProfileLoading());
        final userProfile = await userRepository.getProfile();
        emit(UserProfileLoaded(userProfile!)); // Ensure userProfile is not null
      } catch (error) {
        emit(UserProfileError(error.toString()));
      }
    });

    on<UpdateUserProfile>((event, emit) async {
      try {
        emit(UserProfileLoading());
        await userRepository.updateProfile(event.updateDto);
        // Reload user profile after update
        add(LoadUserProfile()); // Dispatch LoadUserProfile event
        emit(UserProfileUpdateSuccess());
      } catch (error) {
        emit(UserProfileUpdateFailure(error.toString()));
      }
    });

    on<DeleteUserProfile>((event, emit) async {
      try {
        emit(UserProfileLoading());
        await userRepository.deleteProfile();
        emit(UserProfileDeleteSuccess());
      } catch (error) {
        emit(UserProfileDeleteFailure(error.toString()));
      }
    });
  }
}
