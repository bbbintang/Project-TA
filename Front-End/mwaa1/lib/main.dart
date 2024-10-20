import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/AutoFeeder.dart';
import 'package:mwaa1/Screen/control_page.dart';
import 'package:mwaa1/Screen/home_page.dart';
import 'package:mwaa1/Screen/history_page.dart';
import 'package:mwaa1/Screen/profile_page.dart';
import 'package:mwaa1/Screen/regis_screen.dart';
import 'package:mwaa1/Screen/variasi_page.dart';
import 'package:mwaa1/Screen/welcome_screen.dart';
import 'package:mwaa1/Authentications/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}
