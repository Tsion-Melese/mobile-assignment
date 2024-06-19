import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';
import 'package:mobileriverpod/presentation/view/auth/admin_login.dart';
import 'package:mobileriverpod/presentation/view/auth/admin_registration_page.dart';
import 'package:mobileriverpod/presentation/view/auth/login_page.dart';
import 'package:mobileriverpod/presentation/view/auth/user_registration_page.dart';
import 'package:mobileriverpod/presentation/view/job/create_job.dart';
import 'package:mobileriverpod/presentation/view/job/employee_job.dart';
import 'package:mobileriverpod/presentation/view/job/job_seeker_page.dart';
import 'package:mobileriverpod/presentation/view/job/user_job.dart';
import 'package:mobileriverpod/presentation/view/landing/landing_page.dart';
import 'package:mobileriverpod/presentation/view/review/user_review.dart';
import 'package:mobileriverpod/presentation/view/user/admin_user_list_page.dart';
import 'package:mobileriverpod/presentation/view/user/edit_profile.dart';
import 'package:mobileriverpod/presentation/view/user/user_page.dart';
import 'package:mobileriverpod/presentation/view/review/create_review.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LandingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/user-registration',
        builder: (context, state) => RegistrationPage(),
      ),
      GoRoute(
        path: '/admin-login',
        builder: (context, state) => AdminLoginPage(),
      ),
      GoRoute(
        path: '/admin-registration',
        builder: (context, state) => AdminRegistrationPage(),
      ),
      GoRoute(
        path: '/user-list',
        builder: (context, state) => UserListPage(),
      ),
      GoRoute(
      path: '/user',
      builder: (context, state) => UserPage(),
       ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => EditProfilePage(),
    ),
    GoRoute(
      path: '/create-job',
      builder: (context, state) => CreateJobPage(),
    ),
    GoRoute(
      path: '/employee-jobs',
      builder: (context, state) => EmployeeJobPage(),
    ),
    GoRoute(
      path: '/job-seekers-jobs',
      builder: (context, state) => JobSeekerPage(),
    ),
    GoRoute(
      path: '/list-jobs',
      builder: (context, state) => JobListPage(),
    ),
    GoRoute(
      path: '/user-reviews',
      builder: (context, state) => UserReviewsPage(),
    ),
      
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Handy Jobs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
