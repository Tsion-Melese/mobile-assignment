import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tryfront/job/bloc/job_event.dart';
import 'package:tryfront/job/bloc/job_state.dart';
import 'package:tryfront/job/data_provider/jobs_data_provider.dart';
import 'package:tryfront/job/model/job_model.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository jobRepository;

  JobBloc(this.jobRepository) : super(JobInitialState()) {
    on<LoadJobsEvent>((event, emit) => _loadJobs(emit));
    on<CreateJobEvent>((event, emit) => _createJob(event.job, emit));
    on<DeleteJobEvent>((event, emit) => _deleteJob(event.jobId, emit));
    on<UpdateJobEvent>(
        (event, emit) => _updateJob(event.jobId, event.job, emit));
    on<GetJobsByUserIdEvent>(
        (event, emit) => _getJobsByUserId(event.userId, emit));
    on<GetJobsForEmployeesEvent>((event, emit) => _getJobsForEmployees(emit));
    on<GetJobsForJobSeekersEvent>((event, emit) => _getJobsForJobSeekers(emit));
  }

  Future<void> _loadJobs(Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      final jobs = await jobRepository.getJobs();
      emit(JobLoadedState(jobs));
    } catch (error) {
      emit(JobErrorState(error.toString()));
    }
  }

  Future<void> _createJob(Job job, Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      await jobRepository.createJob(job);
      emit(const JobSuccessState("Job created successfully!"));
      // You might want to reload jobs after successful creation.
      // emit(JobLoadedState(await jobRepository.getJobs()));
    } catch (error) {
      emit(JobErrorState(error.toString()));
    }
  }

  Future<void> _deleteJob(String jobId, Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      await jobRepository.deleteJob(jobId);
      emit(const JobSuccessState("Job deleted successfully!"));
      // You might want to reload jobs after successful deletion.
      // emit(JobLoadedState(await jobRepository.getJobs()));
    } catch (error) {
      emit(JobErrorState(error.toString()));
    }
  }

  Future<void> _updateJob(String jobId, Job job, Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      await jobRepository.updateJob(jobId, job);
      emit(const JobSuccessState("Job updated successfully!"));
      // You might want to reload jobs after successful update.
      // emit(JobLoadedState(await jobRepository.getJobs()));
    } catch (error) {
      emit(JobErrorState(error.toString()));
    }
  }

  Future<void> _getJobsByUserId(String userId, Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      final jobs = await jobRepository.getJobsByUserId(userId);
      emit(JobLoadedState(jobs));
    } catch (error) {
      emit(JobErrorState(error.toString()));
    }
  }

  Future<void> _getJobsForEmployees(Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      final jobs = await jobRepository.getJobsForEmployees();
      emit(JobLoadedState(jobs));
    } catch (error) {
      emit(JobErrorState(error.toString()));
    }
  }

  Future<void> _getJobsForJobSeekers(Emitter<JobState> emit) async {
    try {
      emit(JobLoadingState());
      final jobs = await jobRepository.getJobsForJobSeekers();
      emit(JobLoadedState(jobs));
    } catch (error) {
      emit(JobErrorState(error.toString()));
    }
  }
}
