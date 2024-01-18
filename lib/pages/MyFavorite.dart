import 'package:flutter/material.dart';

class MyFavorite extends StatelessWidget {
  const MyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text('Favorite Screen'),
      ),
      body: Center(
        child: Text('This is the Favorite Screen'),
      ),
    );
  }
}
