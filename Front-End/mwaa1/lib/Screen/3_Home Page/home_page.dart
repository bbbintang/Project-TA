import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Services/notification_service.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mwaa1/Screen/3_Home%20Page/custom_parameter.dart';
import 'package:mwaa1/Screen/6_Profile%20Page/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn get googleSignIn => _googleSignIn;
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      await _saveUserData(googleUser);
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> _saveUserData(GoogleSignInAccount user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('displayName', user.displayName ?? '');
    await prefs.setString('photoUrl', user.photoUrl ?? '');
    await prefs.setString('email', user.email);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'displayName': prefs.getString('displayName') ?? '',
      'photoUrl': prefs.getString('photoUrl') ?? '',
      'email': prefs.getString('email') ?? '',
    };
  }
}

class HomePage extends StatefulWidget {
  final String Suhu;
  final String pH;
  final String DO;
  final String TDS;
  final String Udang;
  final String Tambak;
  const HomePage({
    super.key,
    required this.Suhu,
    required this.pH,
    required this.DO,
    required this.TDS,
    required this.Udang,
    required this.Tambak,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  NotificationServices notificationServices = NotificationServices.instance;

  Map<String, String> userData = {};
  final AuthService _authService = AuthService();
  late TabController _tabController;
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    notificationServices.initialize();
    notificationServices.getDeviceToken().then((value) {
      print('Device Token: $value');
    });

    _tabController = TabController(length: 2, vsync: this);
    _loadUserData();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _controller!.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final data = await _authService.getUserData();
    setState(() {
      userData = data;
    });
  }

  Stream<DatabaseEvent> getDatabaseStream(String path) {
    return FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child(path).onValue.asBroadcastStream();
  }

  Color getParameterColor(double value, String title) {
    if (title == "Suhu Air") {
      return (value < 27 || value > 32) ? Colors.red : Colors.white;
    } else if (title == "PH Air") {
      return (value < 7.5 || value > 8.5) ? Colors.red : Colors.white;
    } else if (title == "Oksigen") {
      return (value < 3.5) ? Colors.red : Colors.white;
    } else if (title == "TDS") {
      return (value > 500.0) ? Colors.red : Colors.white;
    }
    return Colors.white;
  }

  Widget buildParameterWidget(
      AsyncSnapshot<DatabaseEvent> snapshot, String imagePath, String title) {
    if (snapshot.hasError) {
      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: 0.0,
        valueColor: Colors.white,
      );
    }

    if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: 0.0,
        valueColor: Colors.white,
      );
    }

    try {
      final value = (snapshot.data!.snapshot.value as num).toDouble();
      final valueColor = getParameterColor(value, title);
      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: value,
        valueColor: valueColor,
      );
    } catch (e) {
      print("Error parsing data untuk $title: $e");
      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: 0.0,
        valueColor: Colors.white,
      );
    }
  }

  Widget buildTabContent(List<Stream<DatabaseEvent>> streams) {
    final titles = ["Suhu Air", "PH Air", "Oksigen", "TDS"];
    final images = ["assets/3.png", "assets/2.png", "assets/4.png", "assets/1.png"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(streams.length, (index) {
          return StreamBuilder<DatabaseEvent>(
            stream: streams[index],
            builder: (context, snapshot) {
              return buildParameterWidget(snapshot, images[index], titles[index]);
            },
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temperatureStream = getDatabaseStream('Temperature');
    final phStream = getDatabaseStream('pH');
    final doStream = getDatabaseStream('DO');
    final tdsStream = getDatabaseStream('TDS');
    final temperature2Stream = getDatabaseStream('Temperature2');
    final ph2Stream = getDatabaseStream('pH2');
    final do2Stream = getDatabaseStream('DO2');
    final tds2Stream = getDatabaseStream('TDS2');

    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 25, bottom: 5, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: userData['displayName']?.isNotEmpty == true
                              ? "Halo ${userData['displayName']}!\n"
                              : "Halo User!\n",
                          style: poppin20bold,
                        ),
                        TextSpan(
                            text: "Pantau Terus Tambak Mu!",
                            style: poppin15normal.copyWith(fontSize: 16)),
                      ]),
                      overflow: TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                        );
                      },
                      child: userData['photoUrl']?.isNotEmpty == true
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(userData['photoUrl']!),
                              radius: 20,
                            )
                          : Image.asset(
                              "assets/LOGOaja.png",
                              height: 85,
                              width: 85,
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TabBarView(
                controller: _tabController,
                children: [
                  buildTabContent([temperatureStream, phStream, doStream, tdsStream]),
                  buildTabContent([temperature2Stream, ph2Stream, do2Stream, tds2Stream]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
