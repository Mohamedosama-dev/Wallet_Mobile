// models/user.dart
class User {
  final String name;
  final String email;
  final String phone;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  // Convert User object to Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  // Create User object from Map (for JSON decoding)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}
