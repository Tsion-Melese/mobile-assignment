import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/infrastructure/job/data_provider/job_data_provider.dart';
import 'package:mobileriverpod/domain/job/model/job_model.dart';
import 'package:mobileriverpod/domain/job/model/update_job_model.dart';
import 'package:mobileriverpod/infrastructure/job/repository/job_repository.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your job repository

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final jobDataProvider = ref.watch(jobDataProviderProvider);
  return ConcreteJobRepository(jobDataProvider);
});

final jobDataProviderProvider = Provider<JobDataProvider>((ref) {
  final dio = Dio(); // Initialize Dio instance
  final sharedPreferencesAsyncValue = ref.watch(sharedPreferencesProvider);

  // Check if the sharedPreferencesAsyncValue is available and has data
  if (sharedPreferencesAsyncValue is AsyncData<SharedPreferences>) {
    final sharedPreferences = sharedPreferencesAsyncValue.value;
    return JobDataProvider(dio, sharedPreferences);
  }

  // Return a default value or handle the error case based on your application's requirements
  throw Exception('Unable to obtain SharedPreferences instance');
});

final jobNotifierProvider =
    StateNotifierProvider<JobNotifier, AsyncValue<List<Job>>>((ref) {
  final jobRepository = ref.watch(jobRepositoryProvider);
  return JobNotifier(jobRepository);
});

class JobNotifier extends StateNotifier<AsyncValue<List<Job>>> {
  final JobRepository _jobRepository;

  JobNotifier(this._jobRepository) : super(AsyncValue.loading()) {
    _fetchJobs();
  }

  Future<void> _fetchJobs() async {
    try {
      final jobs = await _jobRepository.getJobsForEmployees();
      state = AsyncValue.data(jobs);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createJob(Job job) async {
    try {
      final createdJob = await _jobRepository.createJob(job);
      state = state.whenData((jobs) => [...jobs, createdJob]);
    } catch (error) {
      throw error;
    }
  }

  Future<void> getJobsForEmployees() async {
    try {
      final jobs = await _jobRepository.getJobsForEmployees();
      state = AsyncValue.data(jobs);
    } catch (error) {
      throw error;
    }
  }

  Future<void> getJobsForJobSeekers() async {
    try {
      final jobs = await _jobRepository.getJobsForJobSeekers();
      state = AsyncValue.data(jobs);
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteJob(String jobId) async {
    try {
      await _jobRepository.deleteJob(jobId);
      state = state
          .whenData((jobs) => jobs.where((job) => job.jobId != jobId).toList());
    } catch (error) {
      throw error;
    }
  }
}

final EmployeejobNotifierProvider =
    StateNotifierProvider<EmplJobNotifier, AsyncValue<List<Job>>>((ref) {
  final jobRepository = ref.watch(jobRepositoryProvider);
  return EmplJobNotifier(jobRepository);
});

class EmplJobNotifier extends StateNotifier<AsyncValue<List<Job>>> {
  final JobRepository _jobRepository;

  EmplJobNotifier(this._jobRepository) : super(AsyncValue.loading()) {
    _fetchJobs();
  }
  Future<void> _fetchJobs() async {
    try {
      final jobs = await _jobRepository.getJobsForJobSeekers();
      state = AsyncValue.data(jobs);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> getJobsForJobSeekers() async {
    try {
      final jobs = await _jobRepository.getJobsForJobSeekers();
      state = AsyncValue.data(jobs);
    } catch (error) {
      throw error;
    }
  }
}

final userJobNotifierProvider =
    StateNotifierProvider<UserJobNotifier, AsyncValue<List<Job>>>((ref) {
  final jobRepository = ref.watch(jobRepositoryProvider);
  final userId = ref.watch(userIdProvider); // Obtain userId
  return UserJobNotifier(jobRepository, userId);
});

class UserJobNotifier extends StateNotifier<AsyncValue<List<Job>>> {
  final JobRepository _jobRepository;
  final int userId;

  UserJobNotifier(this._jobRepository, this.userId)
      : super(AsyncValue.loading()) {
    _fetchUserJobs();
  }

  Future<void> _fetchUserJobs() async {
    try {
      final jobs = await _jobRepository.getJobsByUserId(userId);
      state = AsyncValue.data(jobs);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Method to add a new job to the user's job list
  void addJob(Job newJob) {
    state = state.maybeWhen(
      data: (jobs) => AsyncValue.data([...jobs, newJob]),
      orElse: () => AsyncValue.data([newJob]),
    );
  }

  Future<void> getJobsByUserId(int userId) async {
    try {
      final jobs = await _jobRepository.getJobsByUserId(userId);
      state = AsyncValue.data(jobs);
    } catch (error) {
      throw error;
    }
  }
}

final updateJobNotifierProvider =
    StateNotifierProvider<UpdateJobNotifier, AsyncValue<UpdateJobDto>>((ref) {
  final jobRepository = ref.watch(jobRepositoryProvider);
  return UpdateJobNotifier(jobRepository);
});

class UpdateJobNotifier extends StateNotifier<AsyncValue<UpdateJobDto>> {
  final JobRepository _jobRepository;

  UpdateJobNotifier(this._jobRepository) : super(AsyncValue.loading());

  Future<void> updateJob(String jobId, UpdateJobDto updatedJob) async {
    try {
      final updatedJobDto = await _jobRepository.updateJob(jobId, updatedJob);
      state = AsyncValue.data(updatedJobDto);
    } catch (error, stackTrace) {
      state = AsyncValue.error(
          error, stackTrace); // You can handle error state here
    }
  }
}
