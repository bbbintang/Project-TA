import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwaa1/widget/custom_category.dart';
import 'package:mwaa1/widget/custom_parameter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
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
                        style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        text: "Pantau Terus Tambak Mu!",
                        style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.notifications_active_rounded,
                                color: Color.fromARGB(255, 28, 88, 136),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Pengingat",
                                style: GoogleFonts.outfit(
                                    color:
                                        const Color.fromARGB(255, 28, 88, 136)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Batas Ukur Parameter Air",
                              style: GoogleFonts.outfit(
                                  color: const Color.fromARGB(255, 28, 88, 136),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5)),
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
                                        name: "Suhu : 26 - 38",
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
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Kategori",
                              style: GoogleFonts.outfit(
                                  color: const Color.fromARGB(255, 28, 88, 136),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.5)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5.0),
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
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomParameter(imagePath: "3.png", title: "Suhu Air",),
                    CustomParameter(imagePath: "2.png", title: "PH Air",),
                    CustomParameter(imagePath: "4.png", title: "Oksigen",),
                    CustomParameter(imagePath: "1.png", title: "TDS",),
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

