import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

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
    );
  }
}