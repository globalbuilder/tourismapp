import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final int userId;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth; 
  final String? image;
  final String? address;
  final String? biography;
  final String? website;

  const ProfileModel({
    required this.userId,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.image,
    this.address,
    this.biography,
    this.website,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      image: json['image'],
      address: json['address'],
      biography: json['biography'],
      website: json['website'],
    );
  }

  @override
  List<Object?> get props => [userId, email, phoneNumber, dateOfBirth, image, address, biography, website];
}
