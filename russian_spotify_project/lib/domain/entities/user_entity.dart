class User {
  final String id;
  final String userName;
  final String email;
  final String? phone;
  final DateTime? birthday;

  User({
    required this.id,
    required this.userName,
    required this.email,
    this.phone,
    this.birthday,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
    );
  }
}
