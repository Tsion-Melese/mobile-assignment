import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/job/bloc/job_bloc.dart';
import 'package:mobilefrontend/job/bloc/job_event.dart';
import 'package:mobilefrontend/job/bloc/job_state.dart';
import 'package:mobilefrontend/job/model/job_model.dart';
import 'package:mobilefrontend/job/view/job_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserJobsPage extends StatefulWidget {
  @override
  _UserJobsPageState createState() => _UserJobsPageState();
}

class _UserJobsPageState extends State<UserJobsPage> {
  late int userId;

  @override
  void initState() {
    super.initState();
    _getUserID();
  }

  Future<void> _getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId') ?? 0;
    // Fetch user's jobs after getting the user ID
    _fetchUserJobs();
  }

  // Define the _fetchUserJobs method
  void _fetchUserJobs() {
    if (userId != 0) {
      BlocProvider.of<JobBloc>(context).add(GetJobsByUserIdEvent(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Jobs'),
      ),
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: Duration(seconds: 2),
              ),
            );
            // After successful deletion, reload the job list
            _fetchUserJobs();
          }
        },
        builder: (context, state) {
          if (state is JobLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is JobLoadedState) {
            final List<Job> jobs = state.jobs;
            return _buildJobsList(jobs);
          } else if (state is JobErrorState) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }

  Widget _buildJobsList(List<Job> jobs) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final Job job = jobs[index];
        return ListTile(
          title: Text(job.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(job.description),
              Text(job.phonenumber),
              Text(job.salary.toString()),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _navigateToEditJobPage(context, job);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteJob(job.jobId!);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteJob(String jobId) {
    BlocProvider.of<JobBloc>(context).add(DeleteJobEvent(jobId));
  }

  void _navigateToEditJobPage(BuildContext context, Job job) {
    if (job.jobId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditJobPage(
            jobId: job.jobId!, // Pass the jobId
            job: job, // Pass the Job object
          ),
        ),
      );
    } else {
      // Handle the case where jobId is null
      print('Error: JobId is null');
    }
  }
}
