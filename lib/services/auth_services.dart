import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'email_services.dart';
import 'otp_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  // Singleton pattern - only one instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();
  static AuthService get instance => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Check if user is logged in
  bool get isLoggedIn => currentUser != null;

  // Get user ID
  String? get userId => currentUser?.uid;

  // Stream of auth state changes (auto-updates when user logs in/out)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ============================================================================
  // GOOGLE SIGN-IN
  // ============================================================================
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      // Step 1: Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        return {'success': false, 'message': 'Sign-in cancelled'};
      }

      // Step 2: Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Step 3: Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: Sign in to Firebase with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      // Step 5: Check if user is new
      final bool isNewUser =
          userCredential.additionalUserInfo?.isNewUser ?? false;

      // Step 6: If new user, create Firestore document
      if (isNewUser) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'name': userCredential.user!.displayName ?? 'User',
          'email': userCredential.user!.email,
          'profilePicture': userCredential.user!.photoURL,
          'phone': userCredential.user!.phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
          'emailVerified': true, // Google accounts are pre-verified
          'signInMethod': 'google',
        });
      }

      notifyListeners();

      return {
        'success': true,
        'message': 'Signed in with Google successfully!',
        'user': userCredential.user,
        'isNewUser': isNewUser,
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Google sign-in failed';
      if (e.code == 'account-exists-with-different-credential') {
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid credentials. Please try again.';
      }

      return {'success': false, 'message': message};
    } catch (e) {
      print('Google Sign-In Error: $e');
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // ============================================================================
  // GOOGLE SIGN-OUT
  // ============================================================================
  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    notifyListeners();
  }

  // ============================================================================
  // REGISTER NEW USER
  // ============================================================================
  Future<Map<String, dynamic>> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      // Step 1: Create user in Firebase Auth
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

      // Step 2: Update display name
      await userCredential.user?.updateDisplayName(name);

      // Step 3: Create user document in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'emailVerified': false,
        'profilePicture': null,
        'phone': phone,
      });

      /// send otp Verificaion
      ///
      await EmailService.instance.sendOTPEmail(
        userName: name,
        email: email.trim(),
        otp: OTPService.instance.generateOTP(),
      );

      notifyListeners(); // Update UI

      return {
        'success': true,
        'message': 'Account created successfully!',
        'user': userCredential.user,
        'requestVerification': true,
      };
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      String message = 'Registration failed';

      if (e.code == 'weak-password') {
        message = 'Password is too weak. Use at least 6 characters.';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email is already registered.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      }

      return {'success': false, 'message': message};
    } catch (e) {
      // Handle other errors
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // ============================================================================
  // LOGIN USER
  // ============================================================================
  Future<Map<String, dynamic>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with Firebase
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email.trim(), password: password);

      notifyListeners(); // Update UI

      return {
        'success': true,
        'message': 'Login successful!',
        'user': userCredential.user,
      };
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      String message = 'Login failed';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      } else if (e.code == 'user-disabled') {
        message = 'This account has been disabled.';
      }

      return {'success': false, 'message': message};
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // ============================================================================
  // LOGOUT USER
  // ============================================================================
  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners(); // Update UI
  }

  // ============================================================================
  // RESET PASSWORD
  // ============================================================================
  Future<Map<String, dynamic>> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());

      return {
        'success': true,
        'message': 'Password reset email sent! Check your inbox.',
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Failed to send reset email';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      }

      return {'success': false, 'message': message};
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  // ============================================================================
  // GET USER DATA FROM FIRESTORE
  // ============================================================================
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      if (userId == null) return null;

      final doc = await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }
}
