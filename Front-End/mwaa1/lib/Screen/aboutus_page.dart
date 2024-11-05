import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 1.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 360,
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
                          const EdgeInsets.only(left: 50, right: 50, top: 8),
                      child: Image.asset(
                        'MWA.png',
                        color: Colors.orange,
                        height: 250,
                      ),
                    ),
                    Positioned(
                      top: 220,
                      left: 16,
                      right: 16,
                      child: Text(
                        'MWA System atau Monitoring Warning and Action System merupakan sebuah produk yang dirancang untuk membantu memantau dan mengontrol kualitas air pada tambak udang',
                        style: poppin15normal.copyWith(
                            color: Colors.black, letterSpacing: 1.0),
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
            ],
          ),
        ));
  }
}
