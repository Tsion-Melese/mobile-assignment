import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String userId; // Change id to userId
  final String username;
  final String email;
  final UserRole? userRole;

  UserProfile({
    required this.userId, // Change id to userId
    required this.username,
    required this.email,
    this.userRole,
  });

  @override
  List<Object?> get props =>
      [userId, username, email, userRole]; // Update props
}

enum UserRole {
  USER,
  ADMIN,
}
