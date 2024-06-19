import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/domain/review/model/review_model.dart';
import 'package:mobileriverpod/application/review/provider/review_riverpod_provider.dart';

class SeeAllReviewsPage extends StatelessWidget {
  final String jobId;

  const SeeAllReviewsPage({required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Reviews'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final reviewsState = ref.watch(reviewsProvider);
          ref.read(reviewsProvider.notifier).getReviewsByJobId(jobId);

          if (reviewsState.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (reviewsState is List<Review>) {
            return ListView.builder(
              itemCount: reviewsState.length,
              itemBuilder: (context, index) {
                final review = reviewsState[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    color: Colors.purple[50],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.content,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < review.rate
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          // Add more review details as needed
                        ],
                      ),
                    ),
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
