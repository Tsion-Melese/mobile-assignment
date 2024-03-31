import 'package:equatable/equatable.dart';
import 'package:tryfront/job/model/job_model.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object?> get props => [];
}

class JobInitialState extends JobState {}

class JobLoadingState extends JobState {}

class JobLoadedState extends JobState {
  final List<Job> jobs;

  const JobLoadedState(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class JobErrorState extends JobState {
  final String message;

  const JobErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class JobSuccessState extends JobState {
  final String message;

  const JobSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
