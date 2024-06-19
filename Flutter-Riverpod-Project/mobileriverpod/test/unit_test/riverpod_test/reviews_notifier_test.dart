import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/application/review/provider/review_riverpod_provider.dart';
import 'package:mobileriverpod/infrastructure/review/repository/review_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mobileriverpod/domain/review/model/review_model.dart';
import 'package:mobileriverpod/domain/review/model/update_review_model.dart';


// Import generated mocks
import 'package:mockito/annotations.dart';
import 'reviews_notifier_test.mocks.dart';

@GenerateMocks([ReviewRepository])
void main() {
  group('ReviewsNotifier', () {
    late MockReviewRepository mockReviewRepository;
    late ReviewsNotifier reviewsNotifier;
    late ProviderContainer container;

    setUp(() {
      mockReviewRepository = MockReviewRepository();
      container = ProviderContainer(overrides: [
        reviewRepositoryProvider.overrideWithValue(mockReviewRepository),
      ]);
      reviewsNotifier = container.read(reviewsProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is empty list', () {
      expect(reviewsNotifier.state, []);
    });

    test('getReviewsByUser updates state with fetched reviews', () async {
      final reviews = [
        Review(
            reviewId: '1',
            content: 'Great job!',
            rate: 5,
            jobId: '1',
            authorId: 1),
        Review(
            reviewId: '2',
            content: 'Nice work!',
            rate: 4,
            jobId: '2',
            authorId: 1),
      ];

      when(mockReviewRepository.getReviewsByUser())
          .thenAnswer((_) async => reviews);

      await reviewsNotifier.getReviewsByUser();

      verify(mockReviewRepository.getReviewsByUser()).called(1);
      expect(reviewsNotifier.state, reviews);
    });

    test('createReview adds new review to state', () async {
      final newReview = Review(
          reviewId: '3',
          content: 'Excellent!',
          rate: 5,
          jobId: '3',
          authorId: 1);
      when(mockReviewRepository.createReview('3', newReview))
          .thenAnswer((_) async => newReview);

      await reviewsNotifier.createReview('3', newReview);

      verify(mockReviewRepository.createReview('3', newReview)).called(1);
      expect(reviewsNotifier.state, [newReview]);
    });

    test('updateReview updates existing review in state', () async {
      final initialReviews = [
        Review(
            reviewId: '1',
            content: 'Good',
            rate: 3,
            jobId: '1',
            authorId: 1),
      ];
      reviewsNotifier.state = initialReviews;

      final updatedReview = Review(
          reviewId: '1',
          content: 'Great job!',
          rate: 5,
          jobId: '1',
          authorId: 1);
      final dto = UpdateReviewDto(id: '1', content: 'Great job!', rate: 5);
      when(mockReviewRepository.updateReview(dto))
          .thenAnswer((_) async => updatedReview);

      await reviewsNotifier.updateReview(dto);

      verify(mockReviewRepository.updateReview(dto)).called(1);
      expect(reviewsNotifier.state, [updatedReview]);
    });

    test('deleteReview removes review from state', () async {
      final initialReviews = [
        Review(
            reviewId: '1',
            content: 'Good',
            rate: 3,
            jobId: '1',
            authorId: 1),
        Review(
            reviewId: '2',
            content: 'Nice',
            rate: 4,
            jobId: '2',
            authorId: 1),
      ];
      reviewsNotifier.state = initialReviews;

      when(mockReviewRepository.deleteReview('1')).thenAnswer((_) async => null);

      await reviewsNotifier.deleteReview('1');

      verify(mockReviewRepository.deleteReview('1')).called(1);
      expect(reviewsNotifier.state, [initialReviews[1]]);
    });
  });
}
