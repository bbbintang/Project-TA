import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/History%20Page/menu_riwayat.dart';
import 'package:mwaa1/Screen/Location%20Page/Location_page.dart';
import 'package:mwaa1/Screen/History%20Page/history_page.dart';
import 'package:mwaa1/Screen/Home%20Page/home_page.dart';
import 'package:mwaa1/Screen/Profile%20Page/profile_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

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

  final List _pages = [
    //home
    HomePage(),

    //Location
    LocationPage(),
    
    //history
    MenuRiwayat(),
    
    //profile
    ProfilePage(),
  ];
  
  @override
  Widget build(BuildContext context) {
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