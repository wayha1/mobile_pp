import 'package:flutter/material.dart';

class Carts extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const Carts({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.green.shade300,
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index]['title']), // Displaying book title
            subtitle: Image.network(cartItems[index]['imageUrl']), // Displaying book image
          );
        },
      ),
    );
  }
}
