import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryfront/job/bloc/job_bloc.dart';
import 'package:tryfront/job/bloc/job_event.dart';
import 'package:tryfront/job/bloc/job_state.dart';
import 'package:tryfront/job/model/job_model.dart';

class EmployerJobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employer Jobs'),
      ),
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is JobLoadedState) {
            return _buildJobList(state.jobs);
          } else if (state is JobErrorState) {
            return Center(
              child: Text(
                  'Error: ${state.message}'), // Use 'message' instead of 'error'
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildJobList(List<Job> jobs) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return ListTile(
          title: Text(job.title),
          subtitle: Text(job.description),
          // Add more details or actions as needed
        );
      },
    );
  }
}
