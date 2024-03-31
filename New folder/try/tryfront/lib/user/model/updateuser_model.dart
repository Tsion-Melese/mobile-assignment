class UpdateUserDto {
  final String? username; // Allow null for optional updates
  final String? email; // Allow null for optional updates

  UpdateUserDto({this.username, this.email});

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
      };
}
