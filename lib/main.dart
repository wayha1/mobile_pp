import 'package:flutter/material.dart';
import 'package:project_practicum/component/my_button_Bar.dart';
import 'package:project_practicum/pages/HomeScreen/Home.dart';
import 'package:project_practicum/pages/Cart_Screen/Carts.dart';
import 'package:project_practicum/pages/CategoryBook_Screen/Categorybook.dart';
import 'package:project_practicum/pages/ContactUs_screen/Contactus.dart';
import 'package:project_practicum/pages/HomeScreen/Homepage.dart';
import 'package:project_practicum/pages/Favorite_screen/MyFavorite.dart';
import 'package:project_practicum/pages/SignIn_Screen/SignIn.dart';
import 'package:project_practicum/pages/SignUp_Screen/SignUp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/category': (context) => const CategoryBook(),
        '/myfavorite' : (context) => const MyFavorite(),
        '/carts' : (context) => const Carts(),
        '/contactus' : (context) => const Contactus(),
        '/account' : (context) => const Account(accessToken: 'accessToken',),
        // '/signIn': (context) => const SignIn(),
        '/signUp': (context) => const SignUp(),
        '/mm': (context) => const MyButtomNavBar(),
      },
    );
  }
}
