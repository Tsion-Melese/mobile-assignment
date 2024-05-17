import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/job/view/user_jobs.dart';
import 'package:mobilefrontend/review/bloc/review_bloc.dart';
import 'package:mobilefrontend/review/bloc/review_event.dart';
import 'package:mobilefrontend/review/bloc/review_state.dart';
import 'package:mobilefrontend/review/model/review_model.dart';
import 'package:mobilefrontend/review/model/update_review_model.dart';
import 'package:mobilefrontend/review/view/user_review_page.dart';

class EditReviewPage extends StatefulWidget {
  final Review review;

  EditReviewPage({required this.review});

  @override
  _EditReviewPageState createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  late TextEditingController _contentController;
  late int _rating;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.review.content);
    _rating = widget.review.rate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _contentController,
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
              onPressed: () => _updateReview(),
              child: Text('Update Review'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateReview() {
    final UpdateReviewDto updatedReview = UpdateReviewDto(
      id: widget.review.reviewId,
      content: _contentController.text,
      rate: _rating,
    );
    BlocProvider.of<ReviewBloc>(context).add(UpdateReviewEvent(updatedReview));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserReviewsPage()));
  }
}
