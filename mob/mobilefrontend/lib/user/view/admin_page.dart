import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/user/bloc/user_bloc.dart';
import 'package:mobilefrontend/user/bloc/user_event.dart';
import 'package:mobilefrontend/user/bloc/user_state.dart';
import 'package:mobilefrontend/user/data_provider/user_data_provider.dart';
import 'package:mobilefrontend/user/model/update_user_model.dart';
import 'package:mobilefrontend/user/model/user_model.dart';
import 'package:mobilefrontend/user/repostory/user_repo.dart';
import 'package:mobilefrontend/user/view/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<AdminProfilePage> {
  late UserProfileBloc _userProfileBloc;
  late UpdateUserDto updatedData; // Initialize updatedData
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = init();
  }

  Future<void> init() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final UserDataProvider userDataProvider = UserDataProvider(
        Dio(), sharedPreferences); // Create an instance of UserDataProvider
    final UserRepository userRepository =
        ConcreteUserRepository(userDataProvider);
    _userProfileBloc = UserProfileBloc(userRepository);
    _userProfileBloc.add(LoadAllUsers()); // Trigger initial profile load
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
        future: _initFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocProvider(
              create: (context) => _userProfileBloc,
              child: BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AllUsersLoaded) {
                    final users = state.users;
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final userProfile = users[index];
                        return ListTile(
                          title: Text(userProfile.username),
                          subtitle: Text(userProfile.email),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Delete'),
                                    content: const Text(
                                        'Are you sure you want to delete this user?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _userProfileBloc.add(
                                              DeleteUserProfileByUserId(userProfile
                                                  .userId)); // Pass userId to the event
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminProfilePage()));
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, // Close onPressed
                          ), // Close trailing
                        ); // Close ListTile
                      }, // Close itemBuilder
                    ); // Close ListView.builder
                  } // Close else if
                  // Add a default return statement if needed
                  return Container(); // Placeholder container
                }, // Close builder function
              ), // Close BlocBuilder
            ); // Close BlocProvider
          } // Close if snapshot.connectionState
          // Add a default return statement if needed
          return Container(); // Placeholder container
        }, // Close builder function
      ), // Close FutureBuilder
    ); // Close Scaffold
  } // Close build method
} // Close _ProfilePageState class
