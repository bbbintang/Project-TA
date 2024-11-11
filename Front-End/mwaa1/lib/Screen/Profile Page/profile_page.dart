import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
      _userName = prefs.getString('displayName') ?? 'Azkiya Nafis Ikrimah';
      _userEmail = prefs.getString('email') ?? 'mwaaa@gmail.com';
      _userPhotoUrl = prefs.getString('photoUrl') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: _userPhotoUrl.isNotEmpty
                    ? Image.network(
                        _userPhotoUrl,
                        height: 170,
                        width: 170,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "profile.jpeg",
                            height: 170,
                            width: 170,
                          );
                        },
                      )
                    : Image.asset(
                        "profile.jpeg",
                        height: 170,
                        width: 170,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '$_userName\n',
                      style: outfit20bold.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 18)),
                  TextSpan(
                      text: _userEmail,
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
                  child: ProfileMenu()),
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
