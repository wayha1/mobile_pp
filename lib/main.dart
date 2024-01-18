import 'package:flutter/material.dart';
import 'package:project_practicum/pages/Home.dart';
import 'package:project_practicum/pages/Carts.dart';
import 'package:project_practicum/pages/Categorybook.dart';
import 'package:project_practicum/pages/Contactus.dart';
import 'package:project_practicum/pages/Homepage.dart';
import 'package:project_practicum/pages/Login.dart';
import 'package:project_practicum/pages/MyFavorite.dart';

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
        '/account' : (context) => const Account(),
        '/login' : (context) => const LoginPage()
      },
    );
  }
}
