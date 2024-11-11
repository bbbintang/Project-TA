import 'package:flutter/material.dart';

class CenteredTabBar extends StatefulWidget {
  @override
  _CenteredTabBarState createState() => _CenteredTabBarState();
}

class _CenteredTabBarState extends State<CenteredTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 Tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TabBar di Tengah Halaman"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300, // Lebar TabBar
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(icon: Icon(Icons.home), text: "Home"),
                  Tab(icon: Icon(Icons.search), text: "Search"),
                  Tab(icon: Icon(Icons.person), text: "Profile"),
                ],
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300, // Lebar TabBarView agar sesuai dengan TabBar
              height: 200, // Tinggi TabBarView
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(child: Text("Home Page")),
                  Center(child: Text("Search Page")),
                  Center(child: Text("Profile Page")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
