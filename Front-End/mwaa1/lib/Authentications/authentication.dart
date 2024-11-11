import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Update GoogleSignIn configuration
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // Add your client ID from Firebase Console
    clientId:
        '348996085369-o3giq3ohcsu0ldne30tectefqklrum51.apps.googleusercontent.com', // Only needed for web
    // Add these configurations
    signInOption: SignInOption.standard,
    hostedDomain: "", // Leave empty to allow any domain
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Check if already signed in
      GoogleSignInAccount? googleUser = _googleSignIn.currentUser;

      googleUser ??= await _googleSignIn.signIn();

      if (googleUser == null) return null;

      // Obtain the auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Save user data
      await _saveUserData(googleUser);

      return userCredential;
    } catch (e) {
      print('Error in signInWithGoogle: $e');
      return null;
    }
  }

  Future<void> _saveUserData(GoogleSignInAccount user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('displayName', user.displayName ?? '');
      await prefs.setString('photoUrl', user.photoUrl ?? '');
      await prefs.setString('email', user.email);
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<Map<String, String>> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return {
        'displayName': prefs.getString('displayName') ?? '',
        'photoUrl': prefs.getString('photoUrl') ?? '',
        'email': prefs.getString('email') ?? '',
      };
    } catch (e) {
      print('Error getting user data: $e');
      return {};
    }
  }
}
