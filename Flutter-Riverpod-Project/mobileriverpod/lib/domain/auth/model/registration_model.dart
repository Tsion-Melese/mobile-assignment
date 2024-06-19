enum Role {
  ADMIN,
  USER, user,
}

class RegistrationData {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  final Role role;

  RegistrationData({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  // Factory method to create an empty instance of RegistrationData
  factory RegistrationData.empty() {
    return RegistrationData(
      email: '',
      password: '',
      username: '',
      firstName: '',
      lastName: '',
      role: Role.USER,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.toString().split('.').last, // Convert enum to string
    };
  }

  static RegistrationData fromJson(Map<String, dynamic> registrationDataJson) {
    if (registrationDataJson == null) {
      throw Exception('Registration data JSON is null');
    }

    return RegistrationData(
      email: registrationDataJson['email'] ?? '',
      password: registrationDataJson['password'] ?? '',
      username: registrationDataJson['username'] ?? '',
      firstName: registrationDataJson['firstName'] ?? '',
      lastName: registrationDataJson['lastName'] ?? '',
      role: registrationDataJson['role'] == 'ADMIN' ? Role.ADMIN : Role.USER,
    );
  }
}
