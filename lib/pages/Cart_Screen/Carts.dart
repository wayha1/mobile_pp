import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Carts extends StatefulWidget {
  final String accessToken;
  //final String imageUrl;
  const Carts({required this.accessToken, Key? key}) : super(key: key);

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  List<dynamic> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchData() when the widget is initialized
  }

  Future<void> fetchData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? widget.accessToken;

      // Make API call to fetch cart items
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/events/cart'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        setState(() {
          cartItems = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          final book = item['book'];
          final bookImage = book['book_image'];
          return ListTile(
            leading: Image.network(
              bookImage,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(book['title']),
          );
        },
      ),
    );
  }
}


