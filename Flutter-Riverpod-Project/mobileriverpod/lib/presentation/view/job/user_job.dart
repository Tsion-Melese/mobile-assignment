import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/application/job/provider/job-riverpod_provider.dart';
import 'package:mobileriverpod/presentation/view/job/job_edit.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';

class JobListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobState = ref.watch(userJobNotifierProvider);

    final userId = ref.watch(userIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
      ),
      body: jobState.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple[900],
                    ),
                    child: Icon(
                      Icons.work,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No jobs yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.purple[900],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                // Refresh the user's job list
                await ref
                    .read(userJobNotifierProvider.notifier)
                    .getJobsByUserId(userId); // No need to pass userId here

                ref.invalidate(jobDataProviderProvider);
              },
              child: ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return Card(
                    color: Colors.purple[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Title:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(job.title),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Description:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(job.description),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditJobPage(
                                              job: job,
                                            )), // Pass the job object here
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Delete the job
                                  ref
                                      .read(jobNotifierProvider.notifier)
                                      .deleteJob(job.jobId!);
                                  ref.invalidate(jobDataProviderProvider);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
