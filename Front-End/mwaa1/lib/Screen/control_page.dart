import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwaa1/Screen/history_page.dart';
import 'package:mwaa1/Screen/home_page.dart';
import 'package:mwaa1/Screen/profile_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {

  //this keeps track of the current pages to display
  int _selectedIndex = 1; 

  //this method updates the new selected index
  void _navigatedBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navtoHome(){
    setState(() {
      _selectedIndex = 1;
    });
  }

  final List _pages = [
    //profile
    ProfilePage(),

    //home
    HomePage(),

    //history
    HistoryPage(),
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
          //profile
          Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),

          //home
          Icon(
            Icons.home,
            color: Colors.white,
            size: 50,
          ),

          //history
          Icon(
            Icons.history_rounded,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }
}