import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/domain/job/model/job_model.dart';
import 'package:mobileriverpod/application/job/provider/job-riverpod_provider.dart';
import 'package:mobileriverpod/application/user/provider/user_riverpod_provider.dart';

class CreateJobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'CREATE JOB',
              style: TextStyle(
                color: Colors.purple[900],
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Container(
                height: 1.0, // Thin line
                color: Colors.grey[700], // Dark gray color
                width: double.infinity, // Extend the line across the whole screen
              ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateJobForm(),
      ),
    );
  }
}

class CreateJobForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  int? _salary;
  String _phonenumber = '';
  UserType _userType = UserType.EMPLOYEE;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Title',
              filled: true,
              fillColor: Colors.purple[50],
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            onSaved: (value) {
              _title = value!;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            maxLines: 4, // Enlarged box for job description
            decoration: InputDecoration(
              labelText: 'Description',
              filled: true,
              fillColor: Colors.purple[50],
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
            onSaved: (value) {
              _description = value!;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Salary',
              filled: true,
              fillColor: Colors.purple[50],
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _salary = int.parse(value);
              } else {
                _salary = null;
              }
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              filled: true,
              fillColor: Colors.purple[50],
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              }
              return null;
            },
            onSaved: (value) {
              _phonenumber = value!;
            },
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<UserType>(
            value: _userType,
            items: UserType.values
                .map((user) => DropdownMenuItem(
                      value: user,
                      child: Text(user.toString().split('.').last),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                _userType = value;
              }
            },
            decoration: InputDecoration(
              labelText: 'User Type',
              filled: true,
              fillColor: Colors.purple[50],
              border: OutlineInputBorder(),
            ),
            dropdownColor: Colors.grey[800],
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final job = Job(
                    title: _title,
                    description: _description,
                    salary: _salary,
                    createrId: ref.read(userIdProvider),
                    userType: _userType,
                    phonenumber: _phonenumber,
                  );
                  try {
                    await ref.read(jobNotifierProvider.notifier).createJob(job);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('created successfully'),
                        
                      ),
                    );

                    // Reset form and clear input fields
                    _formKey.currentState!.reset();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to create job: $error'),
                        
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[900],
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Create Job',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
