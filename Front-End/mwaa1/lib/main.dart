import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Authentications/firebase_options.dart';
import 'package:mwaa1/Screen/start_page.dart';
import 'package:mwaa1/Services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "mwas-95df5",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: StartPage(),
      initialRoute: '/',
      routes: {
        '/welcome_screen': (context) => StartPage(),
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
