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

  //this method updates the new selected index
  void _navigatedBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
@override
Widget build(BuildContext context){
  final List<Widget> _pages = [
    //home
    HomePage (Suhu: widget.Suhu,
        pH: widget.pH,
        DO: widget.DO,
        TDS: widget.TDS,
        Udang: widget.Udang,
        Tambak: widget.Tambak,),

    //Location
    LocationPage(),
    
    //history
    MenuRiwayat(),
    
    //profile
    ProfilePage(),
  ];

return Scaffold(
      body: _pages[_selectedIndex],
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