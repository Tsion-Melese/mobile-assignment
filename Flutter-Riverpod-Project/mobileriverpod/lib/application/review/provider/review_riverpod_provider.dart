import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileriverpod/infrastructure/review/data_provider/review_data_provider.dart';
import 'package:mobileriverpod/domain/review/model/review_model.dart';
import 'package:mobileriverpod/domain/review/model/update_review_model.dart';
import 'package:mobileriverpod/infrastructure/review/repository/review_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider for accessing SharedPreferences
final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Provider for accessing the user ID
final userIdProvider = Provider<int>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  if (sharedPreferences is AsyncData<SharedPreferences>) {
    return sharedPreferences.value.getInt('userId') ?? 0;
  }
  return 0;
});

// Provider for ReviewDataProvider
final reviewDataProviderProvider = Provider<ReviewDataProvider>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final dio = Dio(); // You might want to set up Dio configurations here
  return ReviewDataProvider(dio, sharedPreferences.value!);
});

// Provider for ConcreteReviewRepository
final concreteReviewRepositoryProvider =
    Provider<ConcreteReviewRepository>((ref) {
  final reviewDataProvider = ref.watch(reviewDataProviderProvider);
  return ConcreteReviewRepository(reviewDataProvider);
});

// Provider for accessing ReviewRepository
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ref.watch(concreteReviewRepositoryProvider);
});

// Provider for managing reviews
final reviewsProvider =
    StateNotifierProvider<ReviewsNotifier, List<Review>>((ref) {
  final reviewRepository = ref.watch(reviewRepositoryProvider);
  return ReviewsNotifier(reviewRepository);
});

class ReviewsNotifier extends StateNotifier<List<Review>> {
  final ReviewRepository reviewRepository;

  ReviewsNotifier(this.reviewRepository) : super([]);

  Future<void> getReviewsByUser() async {
    final reviews = await reviewRepository.getReviewsByUser();
    state = reviews;
  }

  Future<void> getReviewsByJobId(String jobId) async {
    final reviews = await reviewRepository.getReviewsByJobId(jobId);
    state = reviews;
  }

  Future<void> createReview(String jobId, Review review) async {
    final newReview = await reviewRepository.createReview(jobId, review);
    state = [...state, newReview];
  }

  Future<void> updateReview(UpdateReviewDto dto) async {
    final updatedReview = await reviewRepository.updateReview(dto);
    state = state
        .map((review) =>
            review.reviewId == updatedReview.reviewId ? updatedReview : review)
        .toList();
  }

  Future<void> deleteReview(String reviewId) async {
    await reviewRepository.deleteReview(reviewId);
    state = state.where((review) => review.reviewId != reviewId).toList();
  }
}
