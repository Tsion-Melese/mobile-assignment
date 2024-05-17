import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/job/bloc/job_bloc.dart';
import 'package:mobilefrontend/job/bloc/job_event.dart';
import 'package:mobilefrontend/job/bloc/job_state.dart';
import 'package:mobilefrontend/job/model/job_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateJobPage extends StatefulWidget {
  @override
  _CreateJobPageState createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<CreateJobPage> {
  final _formKey = GlobalKey<FormState>();
  final _jobTitleController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _salaryController = TextEditingController();
  final _userType = ValueNotifier<UserType>(UserType.EMPLOYEE);
  final _phonenumber = TextEditingController();

  @override
  void dispose() {
    _jobTitleController.dispose();
    _jobDescriptionController.dispose();
    _salaryController.dispose();
    _userType.dispose();
    super.dispose();
  }

  Future<void> _submitJob() async {
    if (_formKey.currentState!.validate()) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final userId = sharedPreferences.getInt('userId');

      if (userId == null) {
        // Handle the case where user ID is not available
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User ID not found. Please log in again.'),
          ),
        );
        return;
      }

      final job = Job(
        title: _jobTitleController.text,
        description: _jobDescriptionController.text,
        salary: int.tryParse(_salaryController.text),
        createrId: userId, // Set the creator ID to the logged-in user's ID
        userType: _userType.value, phonenumber: _phonenumber.text,
      );
      BlocProvider.of<JobBloc>(context).add(CreateJobEvent(job));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Job'),
      ),
      body: BlocListener<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.pop(context); // Navigate back after successful creation
          } else if (state is JobErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _jobTitleController,
                  decoration: InputDecoration(labelText: 'Job Title'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a job title' : null,
                ),
                TextFormField(
                  controller: _jobDescriptionController,
                  decoration: InputDecoration(labelText: 'Job Description'),
                  maxLines: null, // Allow multiline input
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a job description' : null,
                ),
                TextFormField(
                  controller: _phonenumber,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  maxLines: null, // Allow multiline input
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                TextFormField(
                  controller: _salaryController,
                  decoration: InputDecoration(labelText: 'Salary (Optional)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return null;
                    final parsedValue = int.tryParse(value);
                    return parsedValue == null ? 'Invalid salary format' : null;
                  },
                ),
                DropdownButtonFormField<UserType>(
                  value: _userType.value,
                  items: UserType.values
                      .map((user) => DropdownMenuItem(
                            value: user,
                            child: Text(user.toString().split('.').last),
                          ))
                      .toList(),
                  onChanged: (value) => _userType.value = value!,
                  decoration: InputDecoration(labelText: 'User Type'),
                ),
                ElevatedButton(
                  onPressed: _submitJob,
                  child: Text('Create Job'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
