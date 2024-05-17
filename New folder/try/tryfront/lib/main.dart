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
  final AuthRepository authRepository;
  final JobRepository jobRepository;

  const MyApp({
    Key? key,
    required this.authRepository,
    required this.jobRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MultiBlocProvider(
              // Wrap with MultiBlocProvider
              providers: [
                BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(authRepository),
                ),
                BlocProvider<JobBloc>(
                  create: (context) => JobBloc(jobRepository),
                ),
              ],
              child:
                  LoginPage(), // Assuming LoginPage is your login page widget
            ),
        '/profile': (context) => ProfilePage(),
        '/createjob': (context) => BlocProvider<JobBloc>(
              create: (context) => JobBloc(jobRepository),
              child: CreateJobPage(),
            ),
      },
    );
  }
}
