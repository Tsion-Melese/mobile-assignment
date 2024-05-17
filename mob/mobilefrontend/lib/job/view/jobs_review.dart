import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/review/bloc/review_bloc.dart';
import 'package:mobilefrontend/review/bloc/review_event.dart';
import 'package:mobilefrontend/review/bloc/review_state.dart';
import 'package:mobilefrontend/review/model/review_model.dart';

class ReviewsPage extends StatelessWidget {
  final String jobId;

  ReviewsPage({required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReviewLoadedState) {
            final List<Review> reviews = state.reviews;
            return _buildReviewsList(reviews);
          } else if (state is ReviewErrorState) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            return Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }

  Widget _buildReviewsList(List<Review> reviews) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final Review review = reviews[index];
        return ListTile(
          title: Text(review.content),
          subtitle: Text('Rating: ${review.rate.toString()}'),
          // You can display more review details here if needed
        );
      },
    );
  }
}
