import 'package:flutter/material.dart';
import 'package:project_practicum/pages/HomeScreen/Home.dart';
import 'package:project_practicum/pages/Cart_Screen/Carts.dart';
import 'package:project_practicum/pages/CategoryBook_Screen/Categorybook.dart';
import 'package:project_practicum/pages/ContactUs_screen/Contactus.dart';
import 'package:project_practicum/pages/Favorite_screen/MyFavorite.dart';

class MyButtomNavBar extends StatefulWidget {
  const MyButtomNavBar({Key? key}) : super(key: key);

  @override
  State<MyButtomNavBar> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<MyButtomNavBar> {
  int myCurrentIndex = 0;
  List pages = const [
    Account(accessToken: 'access_Token',),
    // Carts(cartItems: [],),
    CategoryBook(),
    Contactus(),
    MyFavorite(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade100, // Set your desired background color
          boxShadow: [
            BoxShadow(
              color: Colors.lightGreen.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(8, 9),
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent, // Set to transparent
            selectedItemColor: Colors.green.shade400,
            unselectedItemColor: Colors.black,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Home"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.bar_chart_outlined), label: "my shelf"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Setting"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "Profile"),
            ],

          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
