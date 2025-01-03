import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Authentications/firebase_options.dart';
import 'package:mwaa1/Screen/History%20Page/grafik_fix.dart';
import 'package:mwaa1/Screen/History%20Page/grafik_page.dart';
import 'package:mwaa1/Screen/History%20Page/menu_riwayat.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/variasi_page.dart';
import 'package:mwaa1/Screen/Profile%20Page/profile_page.dart';
import 'package:mwaa1/Screen/Registrasi%20Page/regis_screen.dart';
import 'package:mwaa1/Screen/Welcome%20Page/welcome_screen.dart';
import 'package:mwaa1/Screen/start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ignore: unused_local_variable
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
      initialRoute: '/',
      routes: {
        '/welcome_screen': (context) => WelcomeScreen(),
      },
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.orange,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent[400],
          ))),
    );
  }
}
