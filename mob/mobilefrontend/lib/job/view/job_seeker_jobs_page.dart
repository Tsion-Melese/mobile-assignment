import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/job/bloc/job_bloc.dart';
import 'package:mobilefrontend/job/bloc/job_event.dart';
import 'package:mobilefrontend/job/bloc/job_state.dart';
import 'package:mobilefrontend/job/model/job_model.dart';
import 'package:mobilefrontend/review/view/create_review_page.dart';
import 'package:mobilefrontend/review/view/jobs_review_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobSeekerJobsPage extends StatefulWidget {
  @override
  _JobSeekerJobsPageState createState() => _JobSeekerJobsPageState();
}

class _JobSeekerJobsPageState extends State<JobSeekerJobsPage> {
  @override
  void initState() {
    super.initState();
    _getJobSeekerJob();
  }

  Future<void> _getJobSeekerJob() async {
    _fetchJobSeekerJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JobSeeker Jobs'),
      ),
      body: BlocBuilder<JobBloc, JobState>(
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
          subtitle: Text(job.description),
          // You can display more job details here if needed
          trailing: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _navigateToCreateReviewPage(context, job.jobId!);
                },
                child: Icon(Icons.rate_review),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _navigateToJobReviewsPage(context, job.jobId!);
                },
                child: Text('See All Reviews'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to initiate fetching user's jobs
  void _fetchJobSeekerJobs() {
    BlocProvider.of<JobBloc>(context).add(GetJobsForJobSeekersEvent());
  }

  void _navigateToCreateReviewPage(BuildContext context, String jobId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateReviewPage(jobId: jobId),
      ),
    );
  }

  void _navigateToJobReviewsPage(BuildContext context, String jobId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobReviewsPage(jobId: jobId),
      ),
    );
  }
}
