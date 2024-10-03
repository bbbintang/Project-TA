import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: Padding(
          padding: const EdgeInsets.only(top: 12, left: 12),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(LineAwesomeIcons.angle_left_solid)),
        ),
        title: SizedBox(width: 160,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 12),
            child: Image.asset(
            "LOGOaja.png",
            height: 100,
            width: 100,
            alignment: Alignment.center,
                    ),
          ),
        ],
      ),
    );
  }
}
