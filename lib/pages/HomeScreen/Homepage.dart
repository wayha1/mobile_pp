import 'package:flutter/material.dart';
import 'package:project_practicum/Logo/logo.dart';
import 'package:project_practicum/component/my_button_Bar.dart';
import 'package:project_practicum/pages/Favorite_screen/MyFavorite.dart';
import 'package:project_practicum/pages/SignIn_Screen/SignIn.dart';
import 'package:project_practicum/pages/SignUp_Screen/SignUp.dart'; // Import your SignIn widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            MyFavorite(accessToken: 'access_Token',),
            MyButtomNavBar(username: 'username', password: 'password',),
            SignUp(),
            SignIn(),
            logo()
          ],
        ),
      ),
    );
  }
}
