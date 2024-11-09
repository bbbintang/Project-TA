import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Tabbarpage extends StatefulWidget {
  const Tabbarpage({super.key});

  @override
  State<Tabbarpage> createState() => _TabbarpageState();
}

class _TabbarpageState extends State<Tabbarpage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: TabBar(
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.orange),
                  controller: tabController,
                  labelPadding: EdgeInsets.symmetric(horizontal: 30),
                  tabs: [
                    Tab(
                      child: Text(
                        'Alat 1',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Alat 2',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
