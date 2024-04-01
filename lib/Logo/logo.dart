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
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            Lottie.asset(
              "assets/Animation - 1711805700503.json",
              width: 310,
              height: 310,
            ),
            // Welcome text
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
      ),
      nextScreen: const SignIn(),
      splashIconSize: 400,
      backgroundColor: Colors.green.shade200,
    );
  }
}

