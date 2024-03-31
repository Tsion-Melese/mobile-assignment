class User {
  final String password;
  final String username;
  final String? email;
  final String? token; // Nullable
  final String? userId; // Nullable

  User({
    required this.password,
    required this.username,
    this.email,
    this.token,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      password: json['password'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      token: json['token'], // Can be null
      userId: json['userId'], // Can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'username': username,
      'email': email,
      'token': token, // Keep as nullable
      'userId': userId, // Keep as nullable
    };
  }
}
