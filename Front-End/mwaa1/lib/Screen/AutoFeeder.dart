import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class Autofeeder extends StatelessWidget {
  const Autofeeder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Center(
          child: Image.asset(
            "LOGOaja.png",
            color: Colors.orange,
            height: 100,
            width: 100,
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "AutoFeeder",
                style: poppin20bold.copyWith(
                    color: Colors.black87, letterSpacing: 1.3, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
