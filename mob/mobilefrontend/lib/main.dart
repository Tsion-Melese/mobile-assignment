import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/auth/bloc/login_bloc.dart';
import 'package:mobilefrontend/auth/data_provider/login_data_providerl.dart';
import 'package:mobilefrontend/auth/repository/login_repo.dart';
import 'package:mobilefrontend/auth/view/login_page.dart';
import 'package:mobilefrontend/job/bloc/job_bloc.dart';
import 'package:mobilefrontend/job/data_provider/job_data_provider.dart';
import 'package:mobilefrontend/job/repostory/job_repostory.dart';
import 'package:mobilefrontend/job/view/job_create.dart';
import 'package:mobilefrontend/review/bloc/review_bloc.dart';
import 'package:mobilefrontend/review/data_provider/review_data_provider.dart';
import 'package:mobilefrontend/user/data_provider/user_data_provider.dart';
import 'package:mobilefrontend/user/repostory/user_repo.dart';
import 'package:mobilefrontend/user/view/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio(); // Instantiate Dio
  final sharedPreferences =
      await SharedPreferences.getInstance(); // Instantiate SharedPreferences

  final userDataProvider =
      UserDataProvider(dio, sharedPreferences); // Instantiate UserDataProvider
  final userRepository = ConcreteUserRepository(
      userDataProvider); // Instantiate ConcreteUserRepository
  final jobRepository = ConcreteJobRepository(
      JobDataProvider(dio, sharedPreferences)); // Instantiate JobRepository
  final authDataProvider =
      AuthDataProvider(dio); // Instantiate AuthDataProvider
  final authRepository = AuthRepository(
      authDataProvider, sharedPreferences); // Instantiate AuthRepository
  final reviewDataProvider = ReviewDataProvider(
      dio, sharedPreferences); // Instantiate ReviewDataProvider

  runApp(MyApp(
    authRepository: authRepository,
    jobRepository: jobRepository,
    reviewDataProvider: reviewDataProvider, // Pass reviewDataProvider to MyApp
  )); // Pass authRepository, jobRepository, and reviewDataProvider to MyApp
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final JobRepository jobRepository;
  final ReviewDataProvider reviewDataProvider; // Add reviewDataProvider

  const MyApp({
    Key? key,
    required this.authRepository,
    required this.jobRepository,
    required this.reviewDataProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository),
        ),
        BlocProvider<JobBloc>(
          create: (context) => JobBloc(jobRepository),
        ),
        BlocProvider<ReviewBloc>(
          // Add ReviewBloc
          create: (context) => ReviewBloc(reviewDataProvider),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/profile': (context) => ProfilePage(),
          '/createjob': (context) => CreateJobPage(),
        },
      ),
    );
  }
}
