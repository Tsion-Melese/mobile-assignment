import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';
import 'package:mobileriverpod/domain/user/model/update_user_model.dart';

class UserProfileWidget extends ConsumerWidget {
  UserProfileWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: userProfile == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: userProfile.username,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final updateDto = UpdateUserDto(
                            username: userProfile.username,
                            email: userProfile.email,
                            firstName: userProfile.firstname,
                            lastName: userProfile.lastname,
                          );
                          ref
                              .read(userProvider.notifier)
                              .updateUserProfile(updateDto);
                        }
                      },
                      child: Text('Update Profile'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(userProvider.notifier).deleteUserProfile();
                      },
                      child: Text('Delete Profile'),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
