import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/detail_page.dart';
import 'package:mwaa1/Screen/regis_screen.dart';
import 'package:mwaa1/Screen/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailPage(),
    );
  }
}