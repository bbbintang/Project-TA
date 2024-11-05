import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/widget/button_homepage.dart';
import 'package:mwaa1/widget/custom_category.dart';
import 'package:mwaa1/widget/custom_category2.dart';
import 'package:mwaa1/widget/custom_parameter.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  @override
  void initState() {
    super.initState();
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      // Check if user is already signed in
      _currentUser = await _googleSignIn.signInSilently();
      
      // Listen for future sign in changes
      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        setState(() {
          _currentUser = account;
          print("Current user: ${_currentUser?.displayName}"); // Debug print
        });
      });

      if (_currentUser == null) {
        // If no silent sign in, try manual sign in
        await _handleSignIn();
      }
    } catch (error) {
      print("Error initializing Google Sign-In: $error");
    }
  }

  Future<void> _handleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      setState(() {
        _currentUser = account;
        print("Signed in user: ${_currentUser?.displayName}"); // Debug print
      });
    } catch (error) {
      print("Error signing in: $error");
    }
  }

  Widget buildParameterWidget(AsyncSnapshot<DatabaseEvent> snapshot, String imagePath, String title) {
    if (snapshot.hasError) {
      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: 0.0,
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
      );
    }

    try {
      final value = (snapshot.data!.snapshot.value as num).toDouble();
      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: value,
      );
    } catch (e) {
      return CustomParameter(
        imagePath: imagePath,
        title: title,
        number: 0.0,
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
                padding: const EdgeInsets.only(left: 30, top: 10, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _currentUser != null 
                                ? "Halo ${_currentUser!.displayName}!\n"
                                : "Halo User!\n",
                            style: poppin20bold,
                          ),
                          TextSpan(
                            text: "Pantau Terus Tambak Mu!", 
                            style: poppin15normal
                          ),
                        ]
                      )
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _currentUser == null ? _handleSignIn : null,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: _currentUser?.photoUrl != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(_currentUser!.photoUrl!),
                                radius: 20,
                              )
                            : Image.asset(
                                "LOGOaja.png",
                                height: 100,
                                width: 100,
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
                          padding: const EdgeInsets.only(left: 16, top: 16),
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
                              child: const Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomCategory(
                                          name1: "PH : ",
                                          name2: "6 - 7",
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CustomCategory(
                                          name1: "TDS : ",
                                          name2: "28 - 30",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomCategory(
                                        name1: "Suhu Air: ",
                                        name2: "100",
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomCategory(
                                        name1: "O2 : ",
                                        name2: "> 3ml/gr",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text("Kategori",
                              style: outfit20bold.copyWith(
                                  letterSpacing: 2.5,
                                  color: darkblue,
                                  fontSize: 17)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomCategory2(kategori: "Udang Vaname"),
                              SizedBox(
                                width: 10,
                              ),
                              CustomCategory2(kategori: "Tambak Intensif")
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
              width: 320,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.3)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    SizedBox(
                      height: 45,
                      width: 148,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: const Color.fromARGB(255, 196, 207, 233),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 10,
                        child: Center(child: Text("Alat 1", style: poppin15normal.copyWith(color: Colors.black),)),
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      height: 45,
                      width: 148,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: const Color.fromARGB(255, 196, 207, 233),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 10,
                        child: Center(child: Text("Alat 2", style: poppin15normal.copyWith(color: Colors.black),)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      StreamBuilder<DatabaseEvent>(
                        stream: database.onValue,
                        builder: (context, snapshot) {
                          return buildParameterWidget(snapshot, "3.png", "Suhu Air");
                        },
                      ),
                      StreamBuilder<DatabaseEvent>(
                        stream: database4.onValue,
                        builder: (context, snapshot) {
                          return buildParameterWidget(snapshot, "2.png", "PH Air");
                        },
                      ),
                      StreamBuilder<DatabaseEvent>(
                        stream: database2.onValue,
                        builder: (context, snapshot) {
                          return buildParameterWidget(snapshot, "4.png", "Oksigen");
                        },
                      ),
                      StreamBuilder<DatabaseEvent>(
                        stream: database3.onValue,
                        builder: (context, snapshot) {
                          return buildParameterWidget(snapshot, "1.png", "TDS");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}