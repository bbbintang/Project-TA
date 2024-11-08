import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mwaa1/widget/profile_menu.dart';
import 'package:mwaa1/widget/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _handleSignIn();
  }

  Future<void> _handleSignIn() async {
    try {
      final user = await _googleSignIn.signInSilently();
      setState(() {
        _currentUser = user;
      });
    } catch (error) {
      print("Error signing in: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    String userName = _currentUser?.displayName ?? 'Azkiya Nafis Ikrimah';
    String userEmail = _currentUser?.email ?? 'mwaaa@gmail.com';
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        elevation: 1.0,
        title: Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(color: Colors.orange),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "LOGOaja.png",
                color: Colors.white,
                height: 100,
                width: 100,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ClipOval(
                  child: Image.asset(
                "profile.jpeg",
                height: 170,
                width: 170,
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '$userName\n',
                      style: outfit20bold.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 18)),
                  TextSpan(
                      text: userEmail,
                      style: outfit20bold.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 18))
                ]),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 300,
              height: 180,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color.fromARGB(255, 196, 207, 233),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 10,
                child: ProfileMenu()
                ),
              ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
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
                          color: Colors.black,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
