import 'package:flutter/material.dart';

class Carts extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const Carts({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          // Build a list tile for each item in the cartItems list
          return ListTile(
            leading: Image.network(cartItems[index]['imageUrl']),
            title: Text(cartItems[index]['title']),
          );
        },
      ),
    );
  }
}
