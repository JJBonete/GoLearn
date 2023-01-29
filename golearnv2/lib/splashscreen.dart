import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:golearnv2/configs/constants.dart';
import 'package:golearnv2/pages/home_page.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

// THIS IS THE CODE FOR THE LOADING SCREEN

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          children: [
            Flexible(
                child: Image.asset('assets/images/GoLearn_foreground.png')),
          ],
        ),
      ),
      backgroundColor: kWhite,
      nextScreen: const HomePage(),
      splashIconSize: 350,
      duration: 1500,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
