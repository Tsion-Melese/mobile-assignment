import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/review/bloc/review_bloc.dart';
import 'package:mobilefrontend/review/bloc/review_event.dart';
import 'package:mobilefrontend/review/model/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateReviewPage extends StatefulWidget {
  final String jobId;

  CreateReviewPage({required this.jobId});

  @override
  _CreateReviewPageState createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final _reviewContentController = TextEditingController();
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _reviewContentController,
              decoration: InputDecoration(labelText: 'Review Content'),
            ),
            SizedBox(height: 16.0),
            Text('Rating: $_rating'),
            Slider(
              value: _rating.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              label: _rating.toString(),
              onChanged: (double value) {
                setState(() {
                  _rating = value.toInt();
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _createReview(context),
              child: Text('Create Review'),
            ),
          ],
        ),
      ),
    );
  }

  void _createReview(BuildContext context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int authorId = sharedPreferences.getInt('userId') ?? 0;

    if (authorId == 0) {
      print('Error: userId is not available');
      return;
    }

    final review = Review(
      reviewId: '',
      content: _reviewContentController.text,
      rate: _rating,
      jobId: widget.jobId,
      authorId: authorId,
    );

    BlocProvider.of<ReviewBloc>(context).add(CreateReviewEvent(
      jobId: widget.jobId,
      review: review,
    ));
    Navigator.pop(context);
  }
}
