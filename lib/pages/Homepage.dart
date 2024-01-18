import 'package:flutter/material.dart';
import 'package:project_practicum/component/my_button_Bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyButtomNavBar(),
    );
  }
}
