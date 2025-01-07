import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/Welcome%20Page/welcome_screen.dart';
import 'package:page_transition/page_transition.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset("assets/MWA.png", scale: 2.5,),
        ],
      ), 
      nextScreen: WelcomeScreen(),
      backgroundColor: Colors.orange,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
