import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/job/bloc/job_bloc.dart';
import 'package:mobilefrontend/job/bloc/job_event.dart';
import 'package:mobilefrontend/job/model/job_model.dart';
import 'package:mobilefrontend/job/model/update_job_model.dart';
import 'package:mobilefrontend/user/view/user_profile.dart';

class EditJobPage extends StatefulWidget {
  final String jobId;
  final Job job;

  const EditJobPage({Key? key, required this.jobId, required this.job})
      : super(key: key);

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _salaryController;
  late TextEditingController _phonenumberController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.job.title);
    _descriptionController =
        TextEditingController(text: widget.job.description);
    _salaryController =
        TextEditingController(text: widget.job.salary?.toString() ?? '');
    _phonenumberController =
        TextEditingController(text: widget.job.phonenumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _phonenumberController,
              decoration: InputDecoration(labelText: 'phonenumber'),
            ),
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateJob(context);
              },
              child: Text('Update Job'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateJob(BuildContext context) {
    final updatedJob = UpdateJobDto(
      jobId: widget.job.jobId!, // Provide the jobId here
      title: _titleController.text,
      description: _descriptionController.text,
      phonenumber: _phonenumberController.text,
      salary: _salaryController.text.isNotEmpty
          ? int.tryParse(_salaryController.text)
          : null,
    );

    BlocProvider.of<JobBloc>(context).add(
      UpdateJobEvent(jobId: widget.job.jobId!, job: updatedJob), // Pass jobId
    );

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfilePage()));
    ;
    ; // Return to the previous screen
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _salaryController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }
}
