import 'package:flutter_test/flutter_test.dart';
import 'package:mobileriverpod/domain/job/model/job_model.dart';

void main() {
  group('Job Model', () {
    test('toJson() should return a valid JSON map', () {
      // Arrange
      final job = Job(
        jobId: '1',
        createdAt: DateTime.parse('2023-06-01T12:34:56.000Z'),
        updatedAt: DateTime.parse('2023-06-02T12:34:56.000Z'),
        title: 'Software Engineer',
        description: 'Develop and maintain software applications.',
        salary: 60000,
        createrId: 100,
        userType: UserType.EMPLOYEE,
        phonenumber: '1234567890',
      );

      // Act
      final jsonMap = job.toJson();

      // Assert
      expect(jsonMap, {
        'id': '1',
        'createdAt': '2023-06-01T12:34:56.000Z',
        'updatedAt': '2023-06-02T12:34:56.000Z',
        'title': 'Software Engineer',
        'description': 'Develop and maintain software applications.',
        'salary': 60000,
        'createrId': 100,
        'userType': 'EMPLOYEE',
        'phonenumber': '1234567890',
      });
    });

    test('fromJson() should return a valid Job object', () {
      // Arrange
      final jsonMap = {
        'id': '1',
        'createdAt': '2023-06-01T12:34:56.000Z',
        'updatedAt': '2023-06-02T12:34:56.000Z',
        'title': 'Software Engineer',
        'description': 'Develop and maintain software applications.',
        'salary': 60000,
        'createrId': 100,
        'userType': 'EMPLOYEE',
        'phonenumber': '1234567890',
      };

      // Act
      final job = Job.fromJson(jsonMap);

      // Assert
      expect(job.jobId, '1');
      expect(job.createdAt, DateTime.parse('2023-06-01T12:34:56.000Z'));
      expect(job.updatedAt, DateTime.parse('2023-06-02T12:34:56.000Z'));
      expect(job.title, 'Software Engineer');
      expect(job.description, 'Develop and maintain software applications.');
      expect(job.salary, 60000);
      expect(job.createrId, 100);
      expect(job.userType, UserType.EMPLOYEE);
      expect(job.phonenumber, '1234567890');
    });

    test('fromJson() should handle missing optional fields gracefully', () {
      // Arrange
      final jsonMap = {
        'id': '1',
        'createdAt': '2023-06-01T12:34:56.000Z',
        'updatedAt': '2023-06-02T12:34:56.000Z',
        'title': 'Software Engineer',
        'description': 'Develop and maintain software applications.',
        'createrId': 100,
        'userType': 'EMPLOYEE',
        'phonenumber': '1234567890',
      };

      // Act
      final job = Job.fromJson(jsonMap);

      // Assert
      expect(job.jobId, '1');
      expect(job.createdAt, DateTime.parse('2023-06-01T12:34:56.000Z'));
      expect(job.updatedAt, DateTime.parse('2023-06-02T12:34:56.000Z'));
      expect(job.title, 'Software Engineer');
      expect(job.description, 'Develop and maintain software applications.');
      expect(job.salary, null);
      expect(job.createrId, 100);
      expect(job.userType, UserType.EMPLOYEE);
      expect(job.phonenumber, '1234567890');
    });

    test('fromJson() should default to EMPLOYEE when userType is unknown', () {
      // Arrange
      final jsonMap = {
        'id': '1',
        'createdAt': '2023-06-01T12:34:56.000Z',
        'updatedAt': '2023-06-02T12:34:56.000Z',
        'title': 'Software Engineer',
        'description': 'Develop and maintain software applications.',
        'salary': 60000,
        'createrId': 100,
        'userType': 'UNKNOWN',
        'phonenumber': '1234567890',
      };

      // Act
      final job = Job.fromJson(jsonMap);

      // Assert
      expect(job.userType, UserType.EMPLOYEE);
    });
  });
}
