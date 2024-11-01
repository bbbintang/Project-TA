import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/widget/button_homepage.dart';
import 'package:mwaa1/widget/custom_category.dart';
import 'package:mwaa1/widget/custom_category2.dart';
import 'package:mwaa1/widget/custom_parameter.dart';
import 'package:mwaa1/widget/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child('Temperature');

    final _database2 = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child('DO');

    final _database3 = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref().child('TDS');

    final _database4 = FirebaseDatabase.instanceFor(
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
              //done
              padding: const EdgeInsets.only(left: 30, top: 10, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "Halo SKY ! \n", style: poppin20bold),
                    TextSpan(
                        text: "Pantau Terus Tambak Mu!", style: poppin15normal),
                  ])),
                  const SizedBox(width: 10),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        "LOGOaja.png",
                        height: 100,
                        width: 100,
                      )),
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
              padding: EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    StreamBuilder(
                        stream: _database.onValue,
                        builder: (context, snapshot) {
                          var temperatur =
                              (snapshot.data!.snapshot.value as num).toDouble();
                          return CustomParameter(
                            imagePath: "3.png",
                            title: "Suhu Air",
                            number: temperatur,
                          );
                        }),
                    StreamBuilder(
                        stream: _database4.onValue,
                        builder: (context, snapshot) {
                          var pH =
                              (snapshot.data!.snapshot.value as num).toDouble();
                          return CustomParameter(
                            imagePath: "2.png",
                            title: "PH Air",
                            number: pH,
                          );
                        }),
                    StreamBuilder(
                        stream: _database2.onValue,
                        builder: (context, snapshot) {
                          var DO =
                              (snapshot.data!.snapshot.value as num).toDouble();
                          return CustomParameter(
                            imagePath: "4.png",
                            title: "Oksigen",
                            number: DO,
                          );
                        }),
                    StreamBuilder(
                        stream: _database3.onValue,
                        builder: (context, snapshot) {
                          var TDS =
                              (snapshot.data!.snapshot.value as num).toDouble();
                          return CustomParameter(
                            imagePath: "1.png",
                            title: "TDS",
                            number: TDS,
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
