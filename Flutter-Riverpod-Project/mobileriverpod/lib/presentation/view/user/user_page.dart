import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobileriverpod/application/job/provider/job-riverpod_provider.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';
import 'package:mobileriverpod/domain/user/model/user_model.dart';
import 'package:mobileriverpod/presentation/view/job/employee_job.dart';
import 'package:mobileriverpod/presentation/view/job/job_seeker_page.dart';
import 'package:mobileriverpod/presentation/view/job/create_job.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileriverpod/presentation/view/job/user_job.dart';
import 'package:mobileriverpod/presentation/view/review/user_review.dart';

class UserPage extends ConsumerStatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  final PageController _pageController = PageController(initialPage: 3);
  int _currentIndex = 3;
  int _profileTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProvider);

    return Scaffold(
      appBar: _currentIndex == 3
          ? AppBar(
              title: Center(
                child: Column(
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              automaticallyImplyLeading: false, // Disable back button
            )
          : null,
      body: userProfile != null
          ? PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                EmployeeJobPage(),
                JobSeekerPage(),
                CreateJobPage(),
                _buildUserProfile(userProfile),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.purple,
        buttonBackgroundColor: Colors.purple[900],
        height: 50,
        index: _currentIndex,
        items: <Widget>[
          Icon(Icons.work, size: 30, color: Colors.white), // Employee Jobs
          Icon(Icons.person, size: 30, color: Colors.white), // Job Seeker
          Icon(Icons.add, size: 30, color: Colors.white), // Create Job
          Icon(Icons.account_circle,
              size: 30, color: Colors.white), // User Profile
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  Widget _buildUserProfile(UserProfile userProfile) {
    return Column(
      children: [
        SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.purple[50], // Set card color
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        _buildUserIcon(),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildUserInfo(userProfile),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 16, // Add left padding
                      endIndent: 16, // Add right padding
                    ),
                  ),
                  SizedBox(height: 16), // Add more space below the divider
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20), // Add space between the card and the button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              context.go('/edit-profile');
            },
            icon: Icon(Icons.edit, color: Colors.white),
            label: Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[900],
              padding: EdgeInsets.symmetric(horizontal: 180, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildUserJobAndReviewIcons(),
        Expanded(child: _buildProfilePageContent())
      ],
    );
  }

  Widget _buildUserIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[800],
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(12),
      child: Icon(
        Icons.person,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Widget _buildUserInfo(UserProfile userProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${userProfile.firstname ?? 'N/A'} ${userProfile.lastname ?? 'N/A'}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          '${userProfile.email ?? 'N/A'}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'User ID: ${userProfile.userId ?? 'N/A'}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildUserJobAndReviewIcons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _profileTabIndex = 0;
                });
              },
              child: Column(
                children: [
                  Icon(Icons.work,
                      size: 20,
                      color:
                          _profileTabIndex == 0 ? Colors.black : Colors.grey),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    height: 2,
                    width: 40,
                    color: _profileTabIndex == 0
                        ? Colors.purple
                        : Colors.transparent,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _profileTabIndex = 1;
                });
              },
              child: Column(
                children: [
                  Icon(Icons.rate_review,
                      size: 20,
                      color:
                          _profileTabIndex == 1 ? Colors.black : Colors.grey),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    height: 2,
                    width: 40,
                    color: _profileTabIndex == 1
                        ? Colors.purple
                        : Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: double.infinity,
          margin: EdgeInsets.only(top: 16),
        ),
      ],
    );
  }

  Widget _buildProfilePageContent() {
    return IndexedStack(
      index: _profileTabIndex,
      children: [
        UserReviewsPage(),
        JobListPage(), // Display JobListPage
      ],
    );
  }
}
