import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/History%20Page/menu_riwayat.dart';
import 'package:mwaa1/Screen/Location%20Page/Location_page.dart';
import 'package:mwaa1/Screen/Home%20Page/home_page.dart';
import 'package:mwaa1/Screen/Profile%20Page/profile_page.dart';

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
      S = "20.20"; T = "11.1"; P = "30.3"; D = "4.14";
    } else if (udang == "Vaname" && tambak == "Intensif") {
      S = "2.20"; T = "15.0"; P = "30.8"; D = "4.44";
    } else if (udang == "Vaname" && tambak == "Super Intensif") {
      S = "20.28"; T = "11.20"; P = "35.2"; D = "55.5";
    } else if (udang == "Udang Galah" && tambak == "Tradisional") {
      S = "20.20"; T = "11.1"; P = "30.3"; D = "4.14";
    } else if (udang == "Udang Galah" && tambak == "Intensif") {
      S = "20"; T = "11"; P = "3"; D = "4";
    } else if (udang == "Udang Galah" && tambak == "Super Intensif") {
      S = "25"; T = "15"; P = "33"; D = "40";
    } else if (udang == "Udang Windu" && tambak == "Tradisional") {
      S = "20.20"; T = "11.1"; P = "30.3"; D = "4.14";
    } else if (udang == "Udang Windu" && tambak == "Intensif") {
      S = "27"; T = "12"; P = "39"; D = "14";
    } else if (udang == "Udang Windu" && tambak == "Super Intensif") {
      S = "50"; T = "30"; P = "20"; D = "50";
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