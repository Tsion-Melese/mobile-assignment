import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/domain/review/model/review_model.dart';
import 'package:mobileriverpod/domain/review/model/update_review_model.dart';
import 'package:mobileriverpod/application/review/provider/review_riverpod_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewEditPage extends ConsumerWidget {
  final Review review;

  const ReviewEditPage({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _contentController =
        TextEditingController(text: review.content);
    final TextEditingController _rateController =
        TextEditingController(text: review.rate.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Review',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 16),
            Text('Rate:', style: TextStyle(color: Colors.black)), // Add rate label
            SizedBox(height: 8),
            RatingBar.builder(
              initialRating: review.rate.toDouble(),
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
                _rateController.text = rating.toInt().toString();
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final updatedReview = UpdateReviewDto(
                  id: review.reviewId,
                  content: _contentController.text,
                  rate: int.parse(_rateController.text),
                );
                ref.read(reviewsProvider.notifier).updateReview(updatedReview);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[900], // Purple[900] color
              ),
              child: Text('Update Review', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
