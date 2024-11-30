import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/AutoFeeder.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/aboutus_page.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/variasi_page.dart';
import 'package:mwaa1/widget/theme.dart';

class ProfileMenu extends StatelessWidget {

  const ProfileMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutUsPage(),
                ));
          },
          leading: Container(
            margin: EdgeInsets.all(5),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white.withOpacity(0.1)),
            child: Icon(
              LineAwesomeIcons.info_circle_solid,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Tentang kami",
            style: outfit17normal.copyWith(color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Autofeeder(),
                ));
          },
          leading: Container(
            margin: EdgeInsets.all(5),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white.withOpacity(0.1)),
            child: Icon(
              LineAwesomeIcons.fish_solid,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Aerator Control",
            style: outfit17normal.copyWith(color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VariasiPage(),
                ));
          },
          leading: Container(
            margin: EdgeInsets.all(5),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white.withOpacity(0.1)),
            child: Icon(
              LineAwesomeIcons.list_alt,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Variasi",
            style: outfit17normal.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}
