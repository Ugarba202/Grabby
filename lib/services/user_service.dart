import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:grabby_app/models/user_profile_model.dart';

class UserService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UserProfileModel? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  UserProfileModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  UserService() {
    // Listen to auth state changes to automatically fetch/create user profile
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        fetchOrCreateUserProfile(user.uid, user.email, user.displayName);
      } else {
        _userProfile = null;
        notifyListeners();
      }
    });
  }

  /// Fetches the user profile from Firestore or creates a new one if it doesn't exist.
  Future<void> fetchOrCreateUserProfile(
    String uid,
    String? email,
    String? displayName,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _userProfile = UserProfileModel.fromFirestore(doc);
        debugPrint('✅ User profile fetched for $uid');
      } else {
        // Create a new profile if it doesn't exist
        _userProfile = UserProfileModel(
          uid: uid,
          name: displayName ?? 'New User',
          email: email ?? 'no-email@example.com',
          createdAt: Timestamp.now(),
        );
        await _firestore
            .collection('users')
            .doc(uid)
            .set(_userProfile!.toFirestore());
        debugPrint('➕ New user profile created for $uid');
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch or create user profile: $e';
      debugPrint('❌ Error in fetchOrCreateUserProfile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Updates the user's profile in Firestore.
  Future<bool> updateUserProfile(Map<String, dynamic> data) async {
    if (_userProfile == null) {
      _errorMessage = 'No user profile to update.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firestore.collection('users').doc(_userProfile!.uid).update(data);
      // Update local model
      _userProfile!.name = data['name'] ?? _userProfile!.name;
      _userProfile!.phoneNumber =
          data['phoneNumber'] ?? _userProfile!.phoneNumber;
      _userProfile!.profilePictureUrl =
          data['profilePictureUrl'] ?? _userProfile!.profilePictureUrl;
      _userProfile!.phoneNumber =
          data['phoneNumber'] ?? _userProfile!.phoneNumber;
      _userProfile!.address = data['address'] ?? _userProfile!.address;
      _userProfile!.bio = data['bio'] ?? _userProfile!.bio;
      _userProfile!.location = data['location'] ?? _userProfile!.location;
      _userProfile!.updatedAt = Timestamp.now();
      debugPrint('✅ User profile updated for ${_userProfile!.uid}');
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update user profile: $e';
      debugPrint('❌ Error updating user profile: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Uploads a profile picture to Firebase Storage and returns its URL.
  Future<String?> uploadProfilePicture(String uid, File imageFile) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final ref = _storage.ref().child(
        'user_profiles/$uid/profile_picture.jpg',
      );
      await ref.putFile(imageFile);
      final url = await ref.getDownloadURL();
      debugPrint('✅ Profile picture uploaded: $url');
      return url;
    } catch (e) {
      _errorMessage = 'Failed to upload profile picture: $e';
      debugPrint('❌ Error uploading profile picture: $e');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
