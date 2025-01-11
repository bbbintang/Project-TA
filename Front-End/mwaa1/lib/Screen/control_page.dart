import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/5_History%20Page/menu_riwayat.dart';
import 'package:mwaa1/Screen/4_Location%20Page/Location_page.dart';
import 'package:mwaa1/Screen/3_Home%20Page/home_page.dart';
import 'package:mwaa1/Screen/6_Profile%20Page/profile_page.dart';

class ControlPage extends StatefulWidget {
  final String Suhu;
  final String pH;
  final String DO;
  final String TDS;
  final String Udang;
  final String Tambak;
  
  const ControlPage({super.key, required this.Suhu,
    required this.pH,
    required this.DO,
    required this.TDS,
    required this.Udang,
    required this.Tambak});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {

  //this keeps track of the current pages to display
  int _selectedIndex = 0; 

  // Method to calculate values based on Udang and Tambak selection
  Map<String, String> getWaterParameters(String udang, String tambak) {
    String S = "Tak ada Nilai", P = "Tak ada Nilai", T = "Tak ada Nilai", D = "Tak ada Nilai";

    if (udang == "Vaname" && tambak == "Tradisional") {
      S = "28-32°C"; T = "100-250"; P = "7,5-8,5"; D = ">3,0";
    } else if (udang == "Vaname" && tambak == "Intensif") {
      S = ">27°C"; T = "100-150"; P = "7,5-8,5"; D = ">4 mg/l";
    } else if (udang == "Vaname" && tambak == "Super Intensif") {
      S = "29-32°C"; T = "100-150"; P = "7,5-8,5"; D = ">4 mg/l";
    } else if (udang == "Udang Galah" && tambak == "Tradisional") {
      S = "28-32°C"; T = "100-250"; P = "7,0-8,5"; D = ">3 mg/l";
    } else if (udang == "Udang Galah" && tambak == "Intensif") {
      S = "28-32°C"; T = "100-250"; P = "7,5-8,5"; D = ">3 mg/l";
    } else if (udang == "Udang Galah" && tambak == "Super Intensif") {
      S = ">27°C"; T = "100-200"; P = "7,5-8,5"; D = ">3 mg/l";
    } else if (udang == "Udang Windu" && tambak == "Tradisional") {
      S = "28-35°C"; T = "100-150"; P = "7,0-8,5"; D = ">3 mg/l";
    } else if (udang == "Udang Windu" && tambak == "Intensif") {
      S = "28-35°C"; T = "100-200"; P = "7,0-8,5"; D = ">3 mg/l";
    } else if (udang == "Udang Windu" && tambak == "Super Intensif") {
      S = "28-35°C"; T = "100-200"; P = "7,5-8,5"; D = ">3 mg/l";
    }

    return {'Suhu': S, 'TDS': T, 'pH': P, 'DO': D};
  }
  //this method updates the new selected index
  void _navigatedBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
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
    LocationPage(isFromButton: false,),
    
    //history
    MenuRiwayat(),
    
    //profile
    ProfilePage(),
  ];

return Scaffold(
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
    );
  }
}