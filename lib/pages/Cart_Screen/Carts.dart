import 'package:flutter/material.dart';

class Carts extends StatelessWidget {
  const Carts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
    );
  }
}
