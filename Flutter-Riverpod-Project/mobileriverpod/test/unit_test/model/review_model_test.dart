import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/review/model/review_model.dart';

void main() {
  group('Review Model', () {
    test('toJson() should return a valid JSON map', () {
      // Arrange
      final review = Review(
        reviewId: '123',
        content: 'Great job!',
        rate: 5,
        jobId: 'job456',
        authorId: 789,
      );

      // Act
      final jsonMap = review.toJson();

      // Assert
      expect(jsonMap, {
        'id': '123',
        'content': 'Great job!',
        'rate': 5,
        'jobId': 'job456',
        'authorId': 789,
      });
    });

    test('fromJson() should return a valid Review object', () {
      // Arrange
      final jsonMap = {
        'id': '123',
        'content': 'Great job!',
        'rate': 5,
        'jobId': 'job456',
        'authorId': 789,
      };

      // Act
      final review = Review.fromJson(jsonMap);

      // Assert
      expect(review.reviewId, '123');
      expect(review.content, 'Great job!');
      expect(review.rate, 5);
      expect(review.jobId, 'job456');
      expect(review.authorId, 789);
    });

    test('Equatable implementation should work correctly', () {
      // Arrange
      final review1 = Review(
        reviewId: '123',
        content: 'Great job!',
        rate: 5,
        jobId: 'job456',
        authorId: 789,
      );
      final review2 = Review(
        reviewId: '123',
        content: 'Great job!',
        rate: 5,
        jobId: 'job456',
        authorId: 789,
      );
      final review3 = Review(
        reviewId: '124',
        content: 'Good job!',
        rate: 4,
        jobId: 'job457',
        authorId: 790,
      );

      // Act & Assert
      expect(review1 == review2, true);
      expect(review1 == review3, false);
    });
  });
}
