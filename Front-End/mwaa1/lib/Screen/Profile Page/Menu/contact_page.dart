import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwaa1/widget/theme.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Info Aplikasi'),
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/MWA.png',
                color: Colors.orange,
                height: 250,
              ),
            ),
            Center(
                child: Text(
              'Versi : 1.0',
              style: poppin15normal.copyWith(color: Colors.black, fontSize: 17),
            )),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact: ta.bismilahsukses@gmail.com',
                    style:
                        GoogleFonts.roboto(color: Colors.black45, fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Copyright © 2024 MWA System. All rights reserved.',
                    style:
                        GoogleFonts.roboto(color: Colors.black45, fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
