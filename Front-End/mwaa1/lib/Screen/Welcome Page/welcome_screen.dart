import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mwaa1/Screen/Registrasi%20Page/regis_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Inisialisasi Google Sign-In
  bool _isGoogleSignInLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithGoogle() async {
    if (_isGoogleSignInLoading) return;
    setState(() {
      _isGoogleSignInLoading = true;
    });

    try {
      // Logout jika ada sesi Google yang sudah ada
      await _googleSignIn.signOut();
      await _auth.signOut();

      // Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'sign_in_canceled',
          message: 'Sign in was canceled by user.',
        );
      }

      // Ambil data autentikasi dari Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null && mounted) {
        // Navigasi ke RegisPage dengan data pengguna
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisScreen(
              displayName: user.displayName ?? "User", // Default jika nama kosong
              email: user.email ?? "",
              photoUrl: user.photoURL ?? "",
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, 'Login gagal: ${e.message}');
    } catch (e) {
      _showErrorDialog(context, 'Terjadi kesalahan: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleSignInLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Welcome To',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    "assets/MWA.png",
                    height: 300,
                    width: 250,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    'Pantau Terus Kualitas dan Kondisi Air pada Pertambakan Mu!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'MWA System merupakan sistem pengawasan dan pengoptimasi kualitas \nair berbasis Internet of Things',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                ),
                onPressed: _isGoogleSignInLoading ? null : _signInWithGoogle,
                child: _isGoogleSignInLoading
                    ? CircularProgressIndicator(color: Colors.black)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/logo_google.jpg",
                            width: 30,
                          ),
                          Text(
                            'Login With Google',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
