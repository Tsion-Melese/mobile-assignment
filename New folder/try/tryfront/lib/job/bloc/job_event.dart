import 'package:tryfront/job/model/job_model.dart';

abstract class JobEvent {
  const JobEvent();
}

class LoadJobsEvent extends JobEvent {
  const LoadJobsEvent();
}

class CreateJobEvent extends JobEvent {
  final Job job;

  const CreateJobEvent(this.job);
}

class DeleteJobEvent extends JobEvent {
  final String jobId;

  const DeleteJobEvent(this.jobId);
}

class UpdateJobEvent extends JobEvent {
  final String jobId;
  final Job job;

  const UpdateJobEvent(this.jobId, this.job);
}

class GetJobsByUserIdEvent extends JobEvent {
  final String userId;

  const GetJobsByUserIdEvent(this.userId);
}

class GetJobsForEmployeesEvent extends JobEvent {
  const GetJobsForEmployeesEvent();
}

class GetJobsForJobSeekersEvent extends JobEvent {
  const GetJobsForJobSeekersEvent();
}
