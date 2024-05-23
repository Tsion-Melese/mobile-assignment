import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefrontend/review/bloc/review_event.dart';
import 'package:mobilefrontend/review/bloc/review_state.dart';
import 'package:mobilefrontend/review/data_provider/review_data_provider.dart';
import 'package:mobilefrontend/review/model/review_model.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewDataProvider reviewDataProvider;

  ReviewBloc(this.reviewDataProvider) : super(ReviewInitialState()) {
    on<CreateReviewEvent>(_createReview);
    on<UpdateReviewEvent>(_updateReview);
    on<DeleteReviewEvent>(_deleteReview);
    on<GetReviewsByUserEvent>(_getReviewsByUser);
    on<GetReviewsByJobIdEvent>(_getReviewsByJobId);
  }

  Future<void> _createReview(
      CreateReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(ReviewLoadingState());
      final review =
          await reviewDataProvider.createReview(event.jobId, event.review);
      emit(ReviewSuccessState("Review created successfully!", review));
    } catch (error) {
      emit(ReviewErrorState(error.toString()));
    }
  }

  Future<void> _updateReview(
      UpdateReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(ReviewLoadingState());
      final updatedReview =
          await reviewDataProvider.updateReview(event.updateReviewDto);

      emit(ReviewSuccessState("Review updated successfully!", updatedReview));
    } catch (error) {
      emit(ReviewErrorState(error.toString()));
    }
  }

  Future<void> _deleteReview(
      DeleteReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(ReviewLoadingState());
      await reviewDataProvider.deleteReview(event.reviewId);

      // Fetch updated reviews after deleting the review
      final List<Review> updatedReviews =
          await reviewDataProvider.getReviewsByUser();

      emit(ReviewLoadedState(updatedReviews));
    } catch (error) {
      emit(ReviewErrorState(error.toString()));
    }
  }

  Future<void> _getReviewsByUser(
      GetReviewsByUserEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(ReviewLoadingState());
      final reviews = await reviewDataProvider.getReviewsByUser();
      emit(ReviewLoadedState(reviews));
    } catch (error) {
      emit(ReviewErrorState(error.toString()));
    }
  }

  Future<void> _getReviewsByJobId(
      GetReviewsByJobIdEvent event, Emitter<ReviewState> emit) async {
    try {
      emit(ReviewLoadingState());
      final reviews = await reviewDataProvider.getReviewsByJobId(event.jobId);
      emit(ReviewLoadedState(reviews));
    } catch (error) {
      emit(ReviewErrorState(error.toString()));
    }
  }
}
