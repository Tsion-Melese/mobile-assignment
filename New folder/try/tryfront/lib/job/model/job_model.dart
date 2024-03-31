import 'package:meta/meta.dart';

enum UserType {
  EMPLOYEE,
  JOB_SEEKER,
}

class Job {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String title;
  final String description;
  final int? salary;
  final String createrId;
  final UserType userType; // Change the type from String to UserType

  Job({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.title,
    required this.description,
    this.salary,
    required this.createrId,
    required this.userType,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      title: json['title'],
      description: json['description'],
      salary: json['salary'],
      createrId: json['createrId'],
      userType:
          _parseUserType(json['userType']), // Parse UserType from JSON string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'title': title,
      'description': description,
      'salary': salary,
      'createrId': createrId,
      'userType': _userTypeToString(userType), // Convert UserType to string
    };
  }

  static UserType _parseUserType(String userTypeString) {
    return UserType.values.firstWhere(
      (type) => type.toString().split('.').last == userTypeString,
      orElse: () => UserType.EMPLOYEE, // Default to EMPLOYEE if parsing fails
    );
  }

  static String _userTypeToString(UserType userType) {
    return userType.toString().split('.').last;
  }
}
