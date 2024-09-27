import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwaa1/Screen/regis_screen.dart';
import 'package:mwaa1/authentication.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Welcome To',
                      style: GoogleFonts.montserrat(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    "MWA.png",
                    height: 300,
                    width: 250,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30.0),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                      text:
                          'Pantau Terus Kualitas dan Kondisi Air pada Pertambakan Mu! \n',
                      style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  TextSpan(
                      text:
                          'MWA System merupakan sistem pengawasan dan pengoptimasi kualitas air berbasis Internet of Things',
                      style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.white))
                ]),
              ),
            ),
            const SizedBox(height: 56.0),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                  iconAlignment: IconAlignment.start,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF0B6EFE),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onPressed: () async {
                    try {
                      // wait for sign-in process
                      UserCredential? userCredential =
                          await AuthService().signInWithGoogle();

                      if (userCredential != null) {
                        // only navigate if sign-in was successful
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisScreen()),
                        );
                      } else {
                        // handle unsuccessful sign-in
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: const Text(
                              'Error',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              'Login gagal. Silakan coba lagi.',
                              style: TextStyle(
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
                    } catch (e) {
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
                            'Error ketika login. Alasan: $e',
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
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "logo_google.jpg",
                        width: 25,
                      ),
                      Text(
                        'Login With Google',
                        style: GoogleFonts.outfit(
                            fontSize: 25.0, color: Colors.white),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
