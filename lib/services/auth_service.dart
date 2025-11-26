import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthService() {
    // Listen to Firebase Auth state changes
    _auth.authStateChanges().listen((User? user) {
      _currentUser = user;
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
      if (user != null) {
        debugPrint('User signed in: ${user.email}');
      } else {
        debugPrint('User signed out.');
      }
    });
  }

  /// Signs in the user with Google.
  Future<User?> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        _isLoading = false;
        notifyListeners();
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      _currentUser = userCredential.user;
      _isLoading = false;
      notifyListeners();
      debugPrint('Google Sign-In successful: ${_currentUser?.email}');
      return _currentUser;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      debugPrint('Firebase Auth Error during Google Sign-In: $e');
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
      debugPrint('Unexpected Error during Google Sign-In: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  /// Signs out the current user from Firebase and Google.
  Future<void> signOut() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    await _auth.signOut();
    await _googleSignIn.signOut(); // Important to sign out from Google as well
    _currentUser = null;
    _isLoading = false;
    notifyListeners();
    debugPrint('User signed out successfully.');
  }
}
