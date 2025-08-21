import 'dart:convert';

UserModel userResponseFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userResponseToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String companyName;
  final String role;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.companyName,
    required this.role,
  });

  // Convert UserModel to Map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'companyName': companyName,
      'role': role,
    };
  }

  // Create UserModel from Firestore document
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      companyName: json['companyName'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
