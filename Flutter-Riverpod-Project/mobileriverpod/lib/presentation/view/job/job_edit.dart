import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/domain/job/model/job_model.dart';
import 'package:mobileriverpod/domain/job/model/update_job_model.dart';
import 'package:mobileriverpod/application/job/provider/job-riverpod_provider.dart';
import 'package:mobileriverpod/presentation/view/user/user_page.dart';

class EditJobPage extends ConsumerWidget {
  final Job job;

  EditJobPage({required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateJobNotifier = ref.read(updateJobNotifierProvider.notifier);

    TextEditingController _titleController =
        TextEditingController(text: job.title);
    TextEditingController _descriptionController =
        TextEditingController(text: job.description);
    TextEditingController _phoneNumberController =
        TextEditingController(text: job.phonenumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Job',
          style: TextStyle(
            color: Colors.purple[900],
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.white, // White app bar background
        elevation: 0, // No shadow
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Thin line
          child: Container(
            color: Colors.grey[700], // Dark gray color
            height: 1.0, // 1 pixel height
            width: double.infinity, // Extend the line across the whole screen
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.grey[700]), // Dark gray label color
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.grey[700]), // Dark gray label color
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.grey[700]), // Dark gray label color
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Prepare the updated job details
                final updatedJob = UpdateJobDto(
                  jobId: job.jobId!,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  salary: job.salary,
                  phonenumber: _phoneNumberController.text,
                );

                // Update the job
                await updateJobNotifier.updateJob(job.jobId!, updatedJob);

                // Invalidate providers to trigger refresh
                ref.invalidate(jobNotifierProvider);
                ref.invalidate(userJobNotifierProvider); // Invalidate userJobNotifierProvider as well

                // Navigate back to the job list page
                Navigator.pop(context, true); // Pass true to indicate changes were saved
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[900], // Purple[900] button color
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.white, // White text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
