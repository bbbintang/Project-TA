import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwaa1/widget/button_detailpage.dart';
import 'package:mwaa1/widget/custom_category.dart';
import 'package:mwaa1/widget/custom_parameter.dart';
import 'package:mwaa1/widget/menu_item.dart';
import 'package:mwaa1/widget/theme.dart';
import 'package:popover/popover.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  

  @override
  Widget build(BuildContext context) {

  final _database = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
).ref().child('Temperature');

  final _database2 = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
).ref().child('DO');

  final _database3 = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
).ref().child('TDS');

  final _database4 = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: "https://mwas-95df5-default-rtdb.asia-southeast1.firebasedatabase.app/",
).ref().child('pH');

    return Scaffold(
      backgroundColor: Colors.orange,
      bottomNavigationBar: CurvedNavigationBar(
        //done
        backgroundColor: Colors.orange,
        color: Colors.orange.shade200,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {},
        items: const [
          Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
            size: 50,
          ),
          Icon(
            Icons.history_rounded,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    TextSpan(
                        text: "Halo BBB ! \n",
                        style: outfit20bold),
                    TextSpan(
                        text: "Pantau Terus Tambak Mu!",
                        style: outfit15normal),
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
              height: 290,
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
                          padding: const EdgeInsets.all(9.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications_active_rounded,
                                color: darkblue,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Pengingat",
                                style: outfit15normal.copyWith(color: darkblue),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 175),
                                child: ButtonDetailPage(),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 9.0),
                          child: Text("Batas Ukur Parameter Air",
                              style: outfit20bold.copyWith(letterSpacing: 1.5, color: darkblue, fontSize: 17)),
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
                              child:  const Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomCategory(
                                          name: "PH : 6 - 7",
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CustomCategory(
                                          name: "TDS : 28 - 30",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomCategory(
                                            name: "Suhu Air: 100",
                                          ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomCategory(
                                        name: "TDS : > 3ml/gr",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 9.0),
                          child: Text("Kategori",
                              style: outfit20bold.copyWith(letterSpacing: 2.5, color: darkblue, fontSize: 17)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomCategory(
                                name: "Udang Vaname",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomCategory(
                                name: "Tambak Intensif",
                              ),
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
                                (snapshot.data!.snapshot.value as num)
                                    .toDouble();
                        return CustomParameter(imagePath: "3.png", title: "Suhu Air", number: temperatur,);
                      }
                    ),
                    StreamBuilder(
                      stream: _database4.onValue,
                      builder: (context, snapshot) {
                        var pH =
                                (snapshot.data!.snapshot.value as num)
                                    .toDouble();
                        return CustomParameter(imagePath: "2.png", title: "PH Air", number: pH,);
                      }
                    ),
                    StreamBuilder(
                      stream: _database2.onValue,
                      builder: (context, snapshot) {
                        var DO =
                                (snapshot.data!.snapshot.value as num)
                                    .toDouble();
                        return CustomParameter(imagePath: "4.png", title: "Oksigen", number: DO,);
                      }
                    ),
                    StreamBuilder(
                      stream: _database3.onValue,
                      builder: (context, snapshot) {
                        var TDS =
                                (snapshot.data!.snapshot.value as num)
                                    .toDouble();
                        return CustomParameter(imagePath: "1.png", title: "TDS", number: TDS,);
                      }
                    ),
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

