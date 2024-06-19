import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/domain/review/model/review_model.dart';
import 'package:mobileriverpod/application/review/provider/review_riverpod_provider.dart';
import 'package:mobileriverpod/presentation/view/review/review_edit_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserReviewsPage extends StatelessWidget {
  const UserReviewsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final reviewsState = ref.watch(reviewsProvider);
          ref.read(reviewsProvider.notifier).getReviewsByUser();

          if (reviewsState.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.rate_review,
                    size: 80,
                    color: Colors.purple[900],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No reviews yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.purple[900],
                    ),
                  ),
                ],
              ),
            );
          } else if (reviewsState is List<Review>) {
            return ListView.builder(
              itemCount: reviewsState.length,
              itemBuilder: (context, index) {
                final review = reviewsState[index];
                return Card(
                  color: Colors.purple[50], // Set card color
                  child: ListTile(
                    title: Text(review.content),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rate: ${review.rate}'),
                        RatingBar.builder(
                          initialRating: review.rate.toDouble(),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Disable rating update
                          },
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReviewEditPage(review: review)),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Delete the review
                            ref
                                .read(reviewsProvider.notifier)
                                .deleteReview(review.reviewId);
                          },
                        ),
                      ],
                    ),
                    // Add more review details as needed
                  ),
                );
              },
            );
          } else if (reviewsState is AsyncError) {
            return Center(
              child: Text('Failed to load reviews: '),
            );
          } else {
            return Center(
              child: Text('Unknown state: $reviewsState'),
            );
          }
        },
      ),
    );
  }
}
