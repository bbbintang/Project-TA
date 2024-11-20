import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Authentications/firebase_options.dart';
import 'package:mwaa1/Screen/History%20Page/history_page.dart';
import 'package:mwaa1/Screen/History%20Page/menu_riwayat.dart';
import 'package:mwaa1/Screen/Welcome%20Page/welcome_screen.dart';
import 'package:mwaa1/Screen/control_page.dart';

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
      home: ControlPage(),
      initialRoute: '/',
      routes: {
        '/welcome_screen' : (context) => WelcomeScreen(),
      },
    );
  }
}
