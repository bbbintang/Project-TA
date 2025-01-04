import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mwaa1/Screen/Profile%20Page/profile_menu.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String _userName = '';
  String _userEmail = '';
  String _userPhotoUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('displayName') ?? 'Login Yuk';
      _userEmail = prefs.getString('email') ?? 'mwaa@gmail.com';
      _userPhotoUrl = prefs.getString('photoUrl') ?? '';
    });
  }

  Future<void> _showSignOutConfirmation() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: outfit17normal.copyWith(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Sign Out',
                style: outfit17normal.copyWith(color: Colors.red),
              ),
            ),
          ],
        );
      },
    ).then((confirmed) async {
      if (confirmed == true) {
        await _handleSignOut();
      }
    });
  }

  Future<void> _handleSignOut() async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();
      print('logout berhasil');
      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      // Navigate to sign in page and remove all previous routes
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/welcome_screen', // Replace with your sign-in page route
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Error signing out: $error');
      // Optionally show error message to user
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing out. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Image.asset(
          "assets/LOGOaja.png",
          color: Colors.white,
          height: 100,
          width: 100,
          alignment: Alignment.center,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        elevation: 1.0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ClipOval(
                child: _userPhotoUrl.isNotEmpty
                    ? Image.network(
                        _userPhotoUrl,
                        height: 170,
                        width: 170,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/profile.jpeg",
                            height: 170,
                            width: 170,
                          );
                        },
                      )
                    : Image.asset(
                        "assets/profile.jpeg",
                        height: 170,
                        width: 170,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: '$_userName\n',
                      style: outfit20bold.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 18)),
                  TextSpan(
                      text: _userEmail,
                      style: outfit17normal.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 16)),
                ]),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 300,
              height: 215,
              child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color.fromARGB(255, 196, 207, 233),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                  child: ProfileMenu()),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: _showSignOutConfirmation,
              child: SizedBox(
                width: 200,
                height: 50,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "LogOut",
                      style: outfit17normal.copyWith(
                          color: Colors.white,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}