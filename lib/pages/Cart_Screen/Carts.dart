import 'package:flutter/material.dart';

class Carts extends StatefulWidget {
  final String imageUrl;

  const Carts({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _CartsState createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  List<String> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        //automaticallyImplyLeading: false,
        title: Text(
          'Carts',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(cartItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  cartItems.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cartItems.add(widget.imageUrl);
  }
}
