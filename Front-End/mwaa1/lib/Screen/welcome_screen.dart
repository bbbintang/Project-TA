import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                        color: Colors.white,),
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
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Pantau Terus Kualitas dan Kondisi Air pada Pertambakan Mu! \n',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                    TextSpan(
                      text: 'MWA System merupakan sistem pengawasan dan pengoptimasi kualitas air berbasis Internet of Things',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white
                      )
                    )
                  ]
                ),
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
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
                onPressed: () {}, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [ 
                    Image.asset("logo_google.jpg", width: 25,),
                    Text('Login With Google', 
                    style: GoogleFonts.outfit(
                      fontSize: 25.0,
                      color: Colors.white
                    ),)
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
