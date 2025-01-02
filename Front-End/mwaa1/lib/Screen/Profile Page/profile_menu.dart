import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/AutoFeeder.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/aboutus_page.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/variasi_page.dart';
import 'package:mwaa1/widget/theme.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({
    super.key,
  });

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  bool statusSwitch = false;
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref();

  @override
  void initState() {
    super.initState();
    print('Initializing aerator listener'); // Debug print
    // Listen to changes in the aerator value
    _database.child('aerator').onValue.listen(
    (event) {
      final value = event.snapshot.value;
      if (value != null) {
        setState(() {
          statusSwitch = event.snapshot.value as bool; // Pastikan boolean
          print('aerator telah terinisialisasi');
        });
      }
    },
    onError: (error) {
      print('Error listening to aerator changes: $error');
    },
  );
  }

  void _toggleAerator(bool value) {
    print('Attempting to toggle aerator to: $value'); // Debug print
    // Update the value in Firebase
    _database.child('aerator').set(value).then((_) {
      print('Successfully updated aerator value'); // Debug print
      setState(() {
        statusSwitch = value;
      });
    }).catchError((error) {
      // Handle any errors
      print('Error updating aerator: $error'); // Debug print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating aerator: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Divider(color: Colors.black45),
        ),
        ListTile(
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
            "Auto-Aerator",
            style: outfit17normal.copyWith(color: Colors.black),
          ),
          trailing: Switch(
            value: statusSwitch,
            onChanged: _toggleAerator,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Divider(color: Colors.black45),
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