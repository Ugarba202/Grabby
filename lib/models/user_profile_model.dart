import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String uid;
  String name;
  String email;
  String? phoneNumber;
  String? profilePictureUrl;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  UserProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profilePictureUrl,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create a UserProfileModel from a Firestore document
  factory UserProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return UserProfileModel(
      uid: doc.id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String?,
      profilePictureUrl: data['profilePictureUrl'] as String?,
      createdAt: data['createdAt'] as Timestamp?,
      updatedAt: data['updatedAt'] as Timestamp?,
    );
  }

  // Method to convert a UserProfileModel to a JSON object for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
