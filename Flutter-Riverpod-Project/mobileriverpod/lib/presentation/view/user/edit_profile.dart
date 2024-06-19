import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';
import 'package:mobileriverpod/domain/user/model/update_user_model.dart';

import 'package:mobileriverpod/application/auth/provider/login_riverpod_provider.dart';

class EditProfilePage extends ConsumerWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProvider);

    if (userProfile != null) {
      // Populate text controllers with existing profile data
      firstNameController.text = userProfile.firstname;
      lastNameController.text = userProfile.lastname;
      usernameController.text = userProfile.username ?? '';
      emailController.text = userProfile.email;
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'EDIT PROFILE',
              style: TextStyle(
                color: Colors.purple[900],
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Container(
              height: 1.0, // Thin line
              color: Colors.grey[700], // Dark gray color
              width: double.infinity, // Extend the line across the whole screen
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/user');
          },
        ),
      ),
      body: userProfile != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 100, // Enlarge the size of the person icon
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                    style: TextStyle(
                        fontSize:
                            18), // Enlarge the font size of the input fields
                  ),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                    style: TextStyle(
                        fontSize:
                            18), // Enlarge the font size of the input fields
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    style: TextStyle(
                        fontSize:
                            18), // Enlarge the font size of the input fields
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    readOnly: true, // Disable editing email
                    style: TextStyle(
                        fontSize:
                            18), // Enlarge the font size of the input fields
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double
                        .infinity, // Make the button extend to the full width
                    child: ElevatedButton(
                      onPressed: () {
                        // Create UpdateUserDto from user input
                        final dto = UpdateUserDto(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          username: usernameController.text,
                          email: userProfile.email,
                        );
                        // Call updateUserProfile to update the profile
                        ref.read(userProvider.notifier).updateUserProfile(dto);
                        context.go('/user'); // Return to the user page
                      },
                      child: Text('Save',
                          style: TextStyle(
                              color: Colors.white)), // Set text color to white
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[900],
                        padding: EdgeInsets.symmetric(
                            vertical: 16), // Enlarge the vertical padding
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Logout?'),
                                content: Text(
                                    'Are you sure you want to logout from your account?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final logoutNotifier =
                                          ref.read(logoutProvider.notifier);
                                      await logoutNotifier.logout();
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      context
                                          .go('/'); // Redirect to landing page
                                    },
                                    child: Text('Logout'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Logout',
                            style: TextStyle(
                                color: Colors.purple[900],
                                fontWeight: FontWeight.bold)),
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Account?'),
                                content: Text(
                                    'This action cannot be undone. Are you sure you want to delete your account?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      final userNotifier =
                                          ref.read(userProvider.notifier);
                                      userNotifier.deleteUserProfile();
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      context
                                          .go('/'); // Redirect to landing page
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Delete Account',
                            style: TextStyle(
                                color: Colors.purple[900],
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
