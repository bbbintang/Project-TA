import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Authentications/firebase_options.dart';
import 'package:mwaa1/Screen/history_page.dart';
import 'package:mwaa1/Screen/start_page.dart';
import 'package:mwaa1/Screen/welcome_screen.dart';

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
      home: StartPage(),
      routes: {
        '/history': (context) => const HistoryPage(),
        '/welcome_screen': (context) => const WelcomeScreen(),
      },
    );
  }
}
