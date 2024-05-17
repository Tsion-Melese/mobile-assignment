import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/view/login_page.dart';
import 'package:mobilefrontend/job/view/user_jobs.dart';
import 'package:mobilefrontend/user/bloc/user_bloc.dart';
import 'package:mobilefrontend/user/bloc/user_event.dart';
import 'package:mobilefrontend/user/bloc/user_state.dart';
import 'package:mobilefrontend/user/data_provider/user_data_provider.dart';
import 'package:mobilefrontend/user/model/update_user_model.dart';
import 'package:mobilefrontend/user/model/user_model.dart';
import 'package:mobilefrontend/user/repostory/user_repo.dart';
import 'package:mobilefrontend/user/view/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserProfileBloc _userProfileBloc;
  late UpdateUserDto updatedData; // Initialize updatedData

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final UserDataProvider userDataProvider = UserDataProvider(
        Dio(), sharedPreferences); // Create an instance of UserDataProvider
    final UserRepository userRepository =
        ConcreteUserRepository(userDataProvider);
    _userProfileBloc = UserProfileBloc(userRepository);
    _userProfileBloc.add(LoadUserProfile()); // Trigger initial profile load
  }

  @override
  void dispose() {
    _userProfileBloc.close(); // Close the bloc when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocProvider<UserProfileBloc>(
              create: (context) => _userProfileBloc,
              child: BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileInitial ||
                      state is UserProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserProfileLoaded) {
                    final userProfile = state.userProfile;
                    // Initialize updatedData with userProfile data
                    updatedData = UpdateUserDto(
                      email: userProfile.email,
                      username: userProfile.username,
                      firstName: userProfile.firstname,
                      lastName: userProfile.lastname,
                    );
                    return _buildProfileContent(userProfile);
                  } else if (state is UserProfileError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return const Text('Unknown state');
                  }
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildProfileContent(UserProfile userProfile) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Username:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(userProfile.username),
          const SizedBox(height: 16.0),
          // Add buttons or other widgets to update or delete profile
          Text(
            'Email:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(userProfile.email),
          const SizedBox(height: 16.0),
          Text(
            'First Name:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(userProfile.firstname),
          const SizedBox(height: 16.0),
          Text(
            'Last Name:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(userProfile.lastname),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                          initialData:
                              updatedData), // Pass updatedData to EditProfilePage
                    ),
                  ).then((value) {
                    if (value != null) {
                      // Handle returned data here if needed
                    }
                  });
                },
                child: const Text('Edit Profile'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserJobsPage(), // Pass updatedData to EditProfilePage
                    ),
                  ).then((value) {
                    if (value != null) {
                      // Handle returned data here if needed
                    }
                  });
                },
                child: const Text('your jobs'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text(
                            'Are you sure you want to delete your profile?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              _userProfileBloc.add(DeleteUserProfile());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete Profile'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
