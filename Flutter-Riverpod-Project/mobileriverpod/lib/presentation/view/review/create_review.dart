import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/domain/review/model/review_model.dart';
import 'package:mobileriverpod/application/review/provider/review_riverpod_provider.dart';

class CreateReviewPage extends StatelessWidget {
  final String jobId;
  final int userId;

  const CreateReviewPage({
    required this.jobId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return ReviewDialog(
      jobId: jobId,
      userId: userId,
    );
  }
}

class ReviewDialog extends StatelessWidget {
  final String jobId;
  final int userId;

  const ReviewDialog({
    required this.jobId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.purple[50], 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: CreateReviewForm(jobId: jobId, userId: userId),
      ),
    );
  }
}

class CreateReviewForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  String _content = '';
  double _rate = 0.0;

  final String jobId;
  final int userId;

  CreateReviewForm({required this.jobId, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Reduce the size
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Comment',
                filled: true,
                fillColor: Colors.white, // Set fill color to white
              ),
              style: TextStyle(color: Colors.black), // Set text color to black
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a comment';
                }
                return null;
              },
              onSaved: (value) {
                _content = value!;
              },
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: Column(
              children: [
                Text('Rating:'),
                RatingBar.builder(
                  initialRating: _rate,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rate = rating;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final review = Review(
                      reviewId: '', // Generate or assign a review ID as needed
                      content: _content,
                      rate: _rate.toInt(),
                      jobId: jobId,
                      authorId: userId,
                    );
                    try {
                      await ref
                          .read(reviewsProvider.notifier)
                          .createReview(jobId, review);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Review created successfully'),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to create review: $error'),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[900], // Purple[900] color
                ),
                child: Text(
                  'Create Review',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8.0), // Add spacing between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Red color for cancel button
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
