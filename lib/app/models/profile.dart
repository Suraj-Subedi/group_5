// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  final bool? success;
  final String? message;
  final User? user;

  ProfileResponse({
    this.success,
    this.message,
    this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        success: json["success"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  final String? fullName;
  final String? email;
  final dynamic address;
  final String? role;

  User({
    this.fullName,
    this.email,
    this.address,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["full_name"],
        email: json["email"],
        address: json["address"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "address": address,
        "role": role,
      };
}
