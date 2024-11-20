import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/contact_page.dart';
import 'package:mwaa1/Screen/Profile%20Page/Menu/faq_page.dart';
import 'package:mwaa1/widget/theme.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: true,
        title: Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 60,),
              Image.asset(
                "LOGOaja.png",
                color: Colors.orange,
                height: 100,
                width: 100,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 410,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Positioned(
                        top: 20,
                        left: 16,
                        child: Text(
                          'Tentang Kami',
                          style: poppin20bold.copyWith(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 50, top: 20),
                      child: Image.asset(
                        'MWA.png',
                        color: Colors.orange,
                        height: 250,
                      ),
                    ),
                    Positioned(
                      top: 250,
                      left: 16,
                      right: 16,
                      child: Text(
                        'MWA System atau Monitoring Warning and Action System merupakan sebuah produk yang dirancang untuk membantu memantau dan mengontrol kualitas air pada tambak udang',
                        style: poppin15normal.copyWith(
                            color: Colors.black, letterSpacing: 1.0, fontSize: 17),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Divider(
                  color: Colors.blueGrey[100],
                  thickness: 1.5,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FAQPage(),
                      ));
                },
                leading: Container(
                  margin: EdgeInsets.all(5),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: Icon(
                    LineAwesomeIcons.question_circle,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                title: Text(
                  "FAQ",
                  style: poppin15normal.copyWith(color: Colors.black, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactPage(),
                      ));
                },
                leading: Container(
                  margin: EdgeInsets.all(5),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: Icon(
                    LineAwesomeIcons.phone_volume_solid,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                title: Text(
                  "Contact Info",
                  style: poppin15normal.copyWith(color: Colors.black, fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,),
              ),
            ],
          ),
        ));
  }
}
