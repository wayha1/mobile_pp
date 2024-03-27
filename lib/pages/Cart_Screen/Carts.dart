import 'package:flutter/material.dart';

class Carts extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems; // Change to non-nullable list


  const Carts({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.green.shade300,
      ),
      body: cartItems.isNotEmpty
          ? ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final title = cartItems[index]['title'] ?? 'Unknown Title';
          final imageUrl = cartItems[index]['imageUrl'] ?? '';

          return ListTile(
            title: Text(title),
            leading: imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : Container(
              width: 50,
              height: 50,
              color: Colors.grey,
            ),
          );
        },
      )
          : Center(
        child: Text('No items in the cart'),
      ),
    );
  }
}
