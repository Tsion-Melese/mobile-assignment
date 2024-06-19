import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/domain/user/model/user_model.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';
import 'package:go_router/go_router.dart'; 

class UserListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(height: 20), // Add space above the icon
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Circle background color
                border: Border.all(
                  color: Colors.black, // Circle border color
                  width: 2.0, // Circle border width
                ),
              ),
              padding: EdgeInsets.all(20), // Circle padding
              child: Icon(
                Icons.manage_accounts_rounded,
                size: 80, // Enlarged icon size
                color: Colors.purple[900],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 150, // Increase the height of the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin-login'); // Navigate to admin login using Go Router
          },
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final userList = ref.watch(userProvider.notifier).getAllUsers();
          return FutureBuilder<List<UserProfile>>(
            future: userList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      color: Colors.purple[100], // Lightened card color
                      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.purple[900],
                            size: 40, // Size of the person icon
                          ),
                          title: Text(
                            '${user.firstname} ${user.lastname}',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            user.email,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.purple[900],
                            ),
                            onPressed: () {
                              _showDeleteConfirmationDialog(
                                  context, ref, user.userId);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, WidgetRef ref, int userId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User?'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(userProvider.notifier).deleteProfileByUserId(userId);
                ref.invalidate(userProvider);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
