import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Authentications/firebase_options.dart';
import 'package:mwaa1/Screen/1_Welcome%20Page/welcome_screen.dart';
import 'package:mwaa1/Screen/start_page.dart';
import 'package:mwaa1/Services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase berhasil diinisialisasi");
  } catch (e) {
    print("Gagal inisialisasi Firebase: $e");
  }
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp( 
      name: "mwas-95df5",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await NotificationServices.instance.initialize();
  }
  
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
