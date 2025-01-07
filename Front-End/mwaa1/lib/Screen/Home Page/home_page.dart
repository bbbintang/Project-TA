import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/Home%20Page/custom_category.dart';
import 'package:mwaa1/Screen/Home%20Page/custom_category2.dart';
import 'package:mwaa1/Screen/Home%20Page/custom_parameter.dart';
import 'package:mwaa1/Screen/Location%20Page/Location_page.dart';
import 'package:mwaa1/Screen/Profile%20Page/profile_page.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Singleton instance of GoogleSignIn to be used across the app
  GoogleSignIn get googleSignIn => _googleSignIn;

  // Get current user
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

      // Save user data to SharedPreferences
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
  const HomePage(
      {super.key,
      required this.Suhu,
      required this.pH,
      required this.DO,
      required this.TDS,
      required this.Udang,
      required this.Tambak});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map<String, String> userData = {};
  final AuthService _authService = AuthService();
  late TabController _tabController; // Menambahkan TabController
  AnimationController? _controller; //animasi gambar maps
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Mengatur jumlah tab
    _loadUserData();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller!)
      ..addListener(
        () {
          setState(() {});
        },
      );

    _controller!.forward();
  }

  @override
  void dispose() {
    _tabController.dispose(); // Pastikan untuk mendispose TabController
    _controller!.forward();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final data = await _authService.getUserData();
    setState(() {
      userData = data;
    });
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

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
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
      
      Color valueColor;
    
    if (title == "Suhu Air") {
      if (value < 27 || value > 32) {
        valueColor = const Color.fromARGB(255, 255, 17, 0); // Jika TDS terlalu tinggi
      } else {
        valueColor = const Color.fromARGB(255, 255, 255, 255); // Jika suhu dalam rentang normal
      }
    } else if (title == "PH Air") {
      if (value < 7.5 || value > 8.5) {
        valueColor = const Color.fromARGB(255, 255, 17, 0); // Jika TDS terlalu tinggi
      } else {
        valueColor = const Color.fromARGB(255, 255, 255, 255); // Jika pH dalam rentang normal
      }
    } else if (title == "Oksigen") {
      if (value < 3000) {
        valueColor = const Color.fromARGB(255, 255, 17, 0); // Jika TDS terlalu tinggi
      } else {
        valueColor = const Color.fromARGB(255, 255, 255, 255); // Jika DO dalam rentang normal
      }
    } else if (title == "TDS") {
      if (value < 100 || value > 200) {
        valueColor = const Color.fromARGB(255, 255, 17, 0); // Jika TDS terlalu tinggi
      } else {
        valueColor = const Color.fromARGB(255, 255, 255, 255); // Jika TDS dalam rentang normal
      }
    } else {
      valueColor = Colors.white; // Default color for unknown titles
    }

      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: value,
        valueColor: valueColor,
      );
    } catch (e) {
      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: 0.0,
        valueColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child('Temperature');

    final database2 = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child('DO');

    final database3 = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child('TDS');

    final database4 = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child('pH');

    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 25, bottom: 5, top: 30),
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
                    const SizedBox(width: 10),
                    Container(
  alignment: Alignment.centerRight,
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(), // Navigasi ke ProfilePage
        ),
      );
    },
    child: userData['photoUrl']?.isNotEmpty == true
        ? CircleAvatar(
            backgroundImage: NetworkImage(userData['photoUrl']!),
            radius: 20,
          )
        : Image.asset(
            "assets/LOGOaja.png", // Gambar default jika tidak ada foto profil
            height: 85,
            width: 85,
          ),
  ),
),
                  ],
                ),
              ),
              SizedBox(
                width: 330,
                height: 270,
                child: Stack(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.white.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 16),
                            child: Text("Batas Ukur Parameter Air",
                                style: outfit20bold.copyWith(
                                    letterSpacing: 1.5,
                                    color: darkblue,
                                    fontSize: 17)),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: const Color.fromARGB(255, 196, 207, 233),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomCategory(
                                          name1: "PH : ",
                                          name2: widget.pH,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomCategory(
                                          name1: "TDS : ",
                                          name2: widget.TDS,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomCategory(
                                          name1: "Suhu Air : ",
                                          name2: widget.Suhu,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomCategory(
                                          name1: "Oksigen : ",
                                          name2: widget.DO,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Kategori",
                                style: outfit20bold.copyWith(
                                    letterSpacing: 2.5,
                                    color: darkblue,
                                    fontSize: 17)),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomCategory2(kategori: widget.Udang),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomCategory2(kategori: widget.Tambak)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationPage(isFromButton: true,),
                        ));
                  },
                  child: Container(
                    height: 100,
                    width: 310,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 5)
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Transform.scale(
                        scale: _animation!.value,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/maps2.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 330, // Lebar TabBar
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: darkblue,
                          unselectedLabelColor: Colors.black,
                          labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                          tabs: [
                            Tab(text: "Alat 1"),
                            Tab(text: "Alat 2"),
                          ],
                          indicatorColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 330, // Lebar TabBarView agar sesuai dengan TabBar
                    height: 200, // Tinggi TabBarView
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                StreamBuilder<DatabaseEvent>(
                                  stream: database.onValue,
                                  builder: (context, snapshot) {
                                    return buildParameterWidget(
                                        snapshot, "assets/3.png", "Suhu Air");
                                  },
                                ),
                                StreamBuilder<DatabaseEvent>(
                                  stream: database4.onValue,
                                  builder: (context, snapshot) {
                                    return buildParameterWidget(
                                        snapshot, "assets/2.png", "PH Air");
                                  },
                                ),
                                StreamBuilder<DatabaseEvent>(
                                  stream: database2.onValue,
                                  builder: (context, snapshot) {
                                    return buildParameterWidget(
                                        snapshot, "assets/4.png", "Oksigen");
                                  },
                                ),
                                StreamBuilder<DatabaseEvent>(
                                  stream: database3.onValue,
                                  builder: (context, snapshot) {
                                    return buildParameterWidget(
                                        snapshot, "assets/1.png", "TDS");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                StreamBuilder<DatabaseEvent>(
                                  stream: database.onValue,
                                  builder: (context, snapshot) {
                                    return buildParameterWidget(
                                        snapshot, "assets/3.png", "Suhu Air");
                                  },
                                ),
                                StreamBuilder<DatabaseEvent>(
                                  stream: database4.onValue,
                                  builder: (context, snapshot) {
                                    return buildParameterWidget(
                                        snapshot, "assets/2.png", "PH Air");
                                  },
                                ),
                                StreamBuilder<DatabaseEvent>(
                                  stream: database2.onValue,
                                  builder: (context, snapshot) {
                                    return buildParameterWidget(
                                        snapshot, "assets/4.png", "Oksigen");
                                  },
                                ),
                                StreamBuilder<DatabaseEvent>(
                                  stream: database3.onValue,
                                  builder: (context, snapshot) {
                                    return buildParameterWidget(
                                        snapshot, "assets/1.png", "TDS");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
