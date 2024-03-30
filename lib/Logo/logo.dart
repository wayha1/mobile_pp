import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_practicum/pages/SignIn_Screen/SignIn.dart';

class logo extends StatelessWidget {
  const logo({Key? key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 5000,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie animation
          Lottie.asset(
            "assets/Animation - 1711807417209.json",
            width: 300,
            height: 300,
          ),
          // Welcome text
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      nextScreen: const SignIn(),
      splashIconSize: 200,
      backgroundColor: Colors.green.shade200,
    );
  }
}
