import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/job/model/update_job_model.dart';

void main() {
  group('UpdateJobDto Model', () {
    test('toJson() should return a valid JSON map', () {
      // Arrange
      final updateJobDto = UpdateJobDto(
        jobId: '123',
        title: 'Software Engineer',
        description: 'Develop and maintain software applications.',
        salary: 60000,
        phonenumber: '1234567890',
      );

      // Act
      final jsonMap = updateJobDto.toJson();

      // Assert
      expect(jsonMap, {
        'id': '123',
        'title': 'Software Engineer',
        'description': 'Develop and maintain software applications.',
        'salary': 60000,
        'phonenumber': '1234567890',
      });
    });

    test('fromJson() should return a valid UpdateJobDto object', () {
      // Arrange
      final jsonMap = {
        'jobId': '123',
        'title': 'Software Engineer',
        'description': 'Develop and maintain software applications.',
        'salary': 60000,
        'phonenumber': '1234567890',
      };

      // Act
      final updateJobDto = UpdateJobDto.fromJson(jsonMap);

      // Assert
      expect(updateJobDto.jobId, '123');
      expect(updateJobDto.title, 'Software Engineer');
      expect(updateJobDto.description, 'Develop and maintain software applications.');
      expect(updateJobDto.salary, 60000);
      expect(updateJobDto.phonenumber, '1234567890');
    });

    test('fromJson() should handle missing optional fields gracefully', () {
      // Arrange
      final jsonMap = {
        'jobId': '123',
        'title': 'Software Engineer',
        'description': 'Develop and maintain software applications.',
        'phonenumber': '1234567890',
      };

      // Act
      final updateJobDto = UpdateJobDto.fromJson(jsonMap);

      // Assert
      expect(updateJobDto.jobId, '123');
      expect(updateJobDto.title, 'Software Engineer');
      expect(updateJobDto.description, 'Develop and maintain software applications.');
      expect(updateJobDto.salary, null); // salary is optional and missing in jsonMap
      expect(updateJobDto.phonenumber, '1234567890');
    });
  });
}
