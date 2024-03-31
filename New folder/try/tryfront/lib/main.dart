import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryfront/auth/view/loginForm.dart';
import 'package:tryfront/job/data_provider/jobs_data_provider.dart';
import 'package:tryfront/job/view/employer_job.dart';
import 'package:tryfront/job/view/job_create.dart';
import 'package:tryfront/job/bloc/job_bloc.dart'; // Import JobBloc
import 'package:tryfront/user/repo/user_repo.dart';
import 'package:tryfront/user/view/profile.dart'; // Import ProfilePage
import 'package:tryfront/user/data_provider/user_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio(); // Instantiate Dio
  final sharedPreferences =
      await SharedPreferences.getInstance(); // Instantiate SharedPreferences

  final userDataProvider =
      UserDataProvider(dio, sharedPreferences); // Instantiate UserDataProvider
  final userRepository = ConcreteUserRepository(
      userDataProvider); // Instantiate ConcreteUserRepository
  final jobRepository = JobRepository(
      dio, sharedPreferences); // Instantiate ConcreteJOBRepository

  runApp(MyApp(jobRepository: jobRepository)); // Pass jobRepository to MyApp
}

class MyApp extends StatelessWidget {
  final JobRepository jobRepository;

  const MyApp({Key? key, required this.jobRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider<JobBloc>(
              create: (context) =>
                  JobBloc(jobRepository), // Provide JobBloc with jobRepository
              child: LoginPage(),
            ),
        '/profile': (context) => ProfilePage(),
        '/createjob': (context) => BlocProvider<JobBloc>(
              create: (context) =>
                  JobBloc(jobRepository), // Provide JobBloc with jobRepository
              child: CreateJobPage(),
            ),
        '/employerjob': (context) => BlocProvider<JobBloc>(
              create: (context) =>
                  JobBloc(jobRepository), // Provide JobBloc with jobRepository
              child: EmployerJobsPage(),
            ),
      },
    );
  }
}
