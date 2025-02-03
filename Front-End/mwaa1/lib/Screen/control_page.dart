import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwaa1/Screen/5_History%20Page/menu_riwayat.dart';
import 'package:mwaa1/Screen/4_Location%20Page/Location_page.dart';
import 'package:mwaa1/Screen/3_Home%20Page/home_page.dart';
import 'package:mwaa1/Screen/6_Profile%20Page/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  final String Suhu;
  final String pH;
  final String DO;
  final String TDS;
  final String Udang;
  final String Tambak;
  final int   currentIndex;

  const ControlPage(
      {super.key,
      required this.Suhu,
      required this.pH,
      required this.DO,
      required this.TDS,
      required this.Udang,
      required this.Tambak,
      this.currentIndex = 0});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  //this keeps track of the current pages to display
  int _selectedIndex = 0; 

  // Method to calculate values based on Udang and Tambak selection
  Map<String, String> getWaterParameters(String udang, String tambak) {
    String S = "Tak ada Nilai",
        P = "Tak ada Nilai",
        T = "Tak ada Nilai",
        D = "Tak ada Nilai";

    if (udang == "Udang Vaname" && tambak == "Tradisional") {
      S = "28-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">3,0";
    } else if (udang == "Udang Vaname" && tambak == "Intensif") {
      S = "27-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">4 mg/l";
    } else if (udang == "Udang Vaname" && tambak == "Super Intensif") {
      S = "29-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">4 mg/l";
    } else if (udang == "Udang Galah" && tambak == "Tradisional") {
      S = "28-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">3,0";
    } else if (udang == "Udang Galah" && tambak == "Intensif") {
      S = "27-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">4 mg/l";
    } else if (udang == "Udang Galah" && tambak == "Super Intensif") {
      S = "29-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">4 mg/l";
    } else if (udang == "Udang Windu" && tambak == "Tradisional") {
      S = "28-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">3,0";
    } else if (udang == "Udang Windu" && tambak == "Intensif") {
      S = "27-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">4 mg/l";
    } else if (udang == "Udang Windu" && tambak == "Super Intensif") {
      S = "29-32°C";
      T = "150-200";
      P = "7,5-8,5";
      D = ">4 mg/l";
    }

    return {'Suhu': S, 'TDS': T, 'pH': P, 'DO': D};
  }

  //this method updates the new selected index
  void _navigatedBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to handle back press with confirmation
  Future<bool> _onBackPressed() async {
    bool? exitApp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop(); // Exits the app
            },
            child: Text("Ya"),
          ),
        ],
      ),
    );

    return exitApp ?? false;
  }

  // Method to check login status (using shared_preferences)
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Use the method to calculate the parameters
    var waterParameters = getWaterParameters(widget.Udang, widget.Tambak);
    final List<Widget> pages = [
      //home
      HomePage(
        Suhu: waterParameters['Suhu']!,
        pH: waterParameters['pH']!,
        DO: waterParameters['DO']!,
        TDS: waterParameters['TDS']!,
        Udang: widget.Udang,
        Tambak: widget.Tambak,
      ),

      //Location
      LocationPage(
        isFromButton: false,
      ),

      //history
      MenuRiwayat(),

      //profile
      ProfilePage(),
    ];

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: pages[_selectedIndex],
        backgroundColor: Colors.orange,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.orange,
          color: Colors.orange.shade200,
          animationDuration: const Duration(milliseconds: 300),
          onTap: _navigatedBottomBar,
          items: [
            //home
            Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),

            //location
            Icon(
              Icons.location_pin,
              color: Colors.white,
              size: 30,
            ),

            //history
            Icon(
              Icons.history_rounded,
              color: Colors.white,
              size: 30,
            ),

            //profile
            Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
