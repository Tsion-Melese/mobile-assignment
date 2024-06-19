import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/review/model/update_review_model.dart';

void main() {
  group('UpdateReviewDto Model', () {
    test('toJson() should return a valid JSON map', () {
      // Arrange
      final updateReviewDto = UpdateReviewDto(
        id: '123',
        content: 'Updated content',
        rate: 4,
      );

      // Act
      final jsonMap = updateReviewDto.toJson();

      // Assert
      expect(jsonMap, {
        'id': '123',
        'content': 'Updated content',
        'rate': 4,
      });
    });

    test('fromJson() should return a valid UpdateReviewDto object', () {
      // Arrange
      final jsonMap = {
        'id': '123',
        'content': 'Updated content',
        'rate': 4,
      };

      // Act
      final updateReviewDto = UpdateReviewDto.fromJson(jsonMap);

      // Assert
      expect(updateReviewDto.id, '123');
      expect(updateReviewDto.content, 'Updated content');
      expect(updateReviewDto.rate, 4);
    });

    test('Equatable implementation should work correctly', () {
      // Arrange
      final updateReviewDto1 = UpdateReviewDto(
        id: '123',
        content: 'Updated content',
        rate: 4,
      );
      final updateReviewDto2 = UpdateReviewDto(
        id: '123',
        content: 'Updated content',
        rate: 4,
      );
      final updateReviewDto3 = UpdateReviewDto(
        id: '124',
        content: 'Another content',
        rate: 5,
      );

      // Act & Assert
      expect(updateReviewDto1 == updateReviewDto2, true);
      expect(updateReviewDto1 == updateReviewDto3, false);
    });
  });
}
