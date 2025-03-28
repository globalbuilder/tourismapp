import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String username;
  final bool isVerified;
  final String? firstName;
  final String? lastName;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.username,
    required this.isVerified,
    this.firstName,
    this.lastName,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      isVerified: json['is_verified'] ?? false,
      firstName: json['first_name'],
      lastName: json['last_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [id, username, isVerified, firstName, lastName, createdAt];
}
