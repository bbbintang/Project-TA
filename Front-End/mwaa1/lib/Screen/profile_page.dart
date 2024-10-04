import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mwaa1/widget/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(LineAwesomeIcons.angle_left_solid)),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const ClipOval(
                  child: Image(
                    image: AssetImage("profile.jpeg"),
                    height: 180,
                    width: 180,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Nama \n',
                          style: outfit17normal.copyWith(fontSize: 20)),
                      TextSpan(
                          text: 'Gmail',
                          style: outfit17normal.copyWith(fontSize: 20))
                    ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
