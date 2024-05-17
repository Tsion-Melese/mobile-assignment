class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? username;
  final String? email;
  final String? password;
  final String? pic;
  final bool? isBlocked;
  final String? token; // Nullable

  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.email,
    this.password,
    this.pic,
    this.isBlocked,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      pic: json['pic'],
      isBlocked: json['isBlocked'],
      token: json['token'], // Can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.toString().split('.').last,
      'username': username,
      'email': email,
      'password': password,
      'pic': pic,
      'isBlocked': isBlocked,
      'token': token, // Keep as nullable
    };
  }
}
