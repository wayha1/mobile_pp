import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/pages/Payment_screen/Payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Carts extends StatefulWidget {
  final String accessToken;
  const Carts({
    required this.accessToken, Key? key,
  }) : super(key: key);

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  List<dynamic> cartItems = [];
  List<int> counts = []; // List to store counts for each item

  @override
  void initState() {
    super.initState();
    fetchData();
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
          // Initialize counts list with zeros for each item
          counts = List<int>.filled(cartItems.length, 1);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Function to increment the count for a specific index
  void incrementCount(int index) {
    setState(() {
      counts[index]++;
    });
  }

  // Function to decrement the count for a specific index
  void decrementCount(int index) {
    if (counts[index] > 0) {
      setState(() {
        counts[index]--;
      });
    }
  }

  // Function to show a confirmation dialog
  Future<void> showDeleteConfirmationDialog(BuildContext context, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                // Show a loading indicator after a short delay
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade400), // Customize the color here
                      ),
                    );
                  },
                );
                // Add a short delay to ensure the loading indicator is displayed
                await Future.delayed(Duration(milliseconds: 1000));
                // Call the function to delete the item
                await deleteItem(index);
                // Fetch data again to update the UI
                await fetchData();
                // Close the loading indicator dialog
                Navigator.of(context).pop();
                // Close the confirmation dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to delete the item
  Future<void> deleteItem(int index) async {
    try {
      final item = cartItems[index];
      final int itemId = item['id']; // Assuming 'id' is the key for the item's ID
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? widget.accessToken;

      // Make DELETE request to the API endpoint with the item ID
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:5000/events/cart/$itemId'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        // Item deleted successfully, update the UI or fetch data again
        fetchData();
      } else {
        // Handle error
        print('Failed to delete item');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = 0; // Initialize total
    for (int i = 0; i < cartItems.length; i++) {
      var price = cartItems[i]['book']['price']; // Get the price of the item
      if (price is String) {
        price = double.parse(price); // Convert price to double if it's a string
      }
      total += counts[i] * price; // Calculate total based on counts and prices
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        leading: Center(
          child: Image.asset(
            'lib/image/logo.png',
            width: 50,
            height: 50,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Carts',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Container(
          child: Stack(
            children: [
              // Image
              Image.asset(
                'assets/emptybox.png', // Replace with your image path
                width: 150, // Adjust width as needed
                height: 150, // Adjust height as needed
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 30),
                child: Text(
                  'Cart is empty',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final book = item['book'];
                final bookImage = book['book_image'];
                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 30),
                    child: Row(
                      children: [
                        Image(
                          image: NetworkImage(bookImage),
                          width: 150,
                          height: 175,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Title: ${book['title']}',
                                    ),
                                    Text(
                                      'Price: ${book['price']} \$',
                                    ),
                                    SizedBox(height: 10), // Add spacing between title, price, and buttons
                                    Container(
                                      color: Colors.grey.shade300,
                                      width: 110,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => decrementCount(index),
                                            icon: Icon(Icons.remove),
                                          ),
                                          Text('${counts[index]}'), // Display the current count for this item
                                          IconButton(
                                            onPressed: () => incrementCount(index),
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDeleteConfirmationDialog(context, index);
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total: \$${total.toStringAsFixed(2)}', // Display total with 2 decimal places
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: cartItems.isEmpty
          ? Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              // Image
              Image.asset(
                'assets/emptybox.png', // Replace with your image path
                width: 250, // Adjust width as needed
                height: 250, // Adjust height as needed
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 70),
                child: Text(
                  'Cart is empty',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : BottomAppBar(
        child: Container(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  if (cartItems.isNotEmpty) {
                    final bookId = cartItems.first['book']['id'];
                    final price = cartItems.first['book']['price'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Payment(
                          accessToken: widget.accessToken,
                          bookId: bookId, price: price,
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
