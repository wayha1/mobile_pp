import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class Payment extends StatefulWidget {
  final String accessToken;
  final int bookId;
  final String price; // Add the price as a parameter

  const Payment({super.key, required this.accessToken, required this.bookId, required this.price}); // Include the price

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController(); // Corrected to _cardHolderNameController
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    _expirationDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> paymentCarts() async {
    try {
      // Retrieve access token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        print('Access token not found. Cannot add to payment');
        return;
      }

      // Retrieve user_id from SharedPreferences
      final int? userId = prefs.getInt('user_id');

      if (userId == null) {
        // User is not signed in, handle the case accordingly
        print('User ID is null. Cannot proceed with payment.');
        return;
      }

      // Prepare the data to send
      final Map<String, dynamic> dataPayment = {
        "user_id": userId,
        "book_id": widget.bookId,
        "card_number": _cardNumberController.text,
        "card_holder_name": _cardHolderNameController.text,
        "expiration_date": _expirationDateController.text,
        "cvv": _cvvController.text,
        "price": widget.price,
      };

      // Print the data
      print('Payment Data: $dataPayment');

      // Convert data to JSON
      final jsonData = jsonEncode(dataPayment);

      // Send POST request
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/events/payment'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonData,
      );

      // Check if request was successful
      if (response.statusCode == 201) {
        // Data successfully added to cart
        print('Payment successful');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Text('Payment successful!'),
                ),
                Icon(Icons.check_circle_outline, color: Colors.white),
              ],
            ),
            backgroundColor: Colors.green.shade500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        print('Failed to process payment. Status code: ${response.statusCode}');
      }
      // Clear input fields after processing payment
      _cardNumberController.clear();
      _cardHolderNameController.clear();
      _expirationDateController.clear();
      _cvvController.clear();
    } catch (error) {
      // Handle any errors
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Expanded(
                child: Text('Failed to process payment.'),
              ),
              Icon(Icons.error_outline, color: Colors.white),
            ],
          ),
          backgroundColor: Colors.red.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'Cancel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade500,
            fontSize: 23,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, bottom: 10),
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30, bottom: 10),
                    child: TextButton(
                      onPressed: paymentCarts,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Container(
                          width: 100,
                          height: 40, // Set the height of the container
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            // Center the text vertically and horizontally
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade500,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/card.webp',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 12),
                child: Text(
                  'Card number',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Container(
                width: 390,
                margin: EdgeInsets.only(top: 5, left: 10),
                color: Colors.grey.shade300,
                child: TextField(
                  controller: _cardNumberController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.credit_card),
                    labelText: "Card_number",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 12),
                child: Text(
                  'Card holder name',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Container(
                width: 390,
                margin: EdgeInsets.only(top: 5, left: 10),
                color: Colors.grey.shade300,
                child: TextField(
                  controller: _cardHolderNameController, // Corrected to _cardHolderNameController
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.credit_card),
                    labelText: "Card_holder_name",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 12),
                child: Text(
                  'Expiration Date',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Container(
                width: 390,
                margin: EdgeInsets.only(top: 5, left: 10),
                color: Colors.grey.shade300,
                child: TextField(
                  controller: _expirationDateController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.credit_card),
                    labelText: "Expiration_date",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 12),
                child: Text(
                  'Cvv',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Container(
                width: 390,
                margin: EdgeInsets.only(top: 5, left: 10, bottom: 20),
                color: Colors.grey.shade300,
                child: TextField(
                  controller: _cvvController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.credit_card),
                    labelText: "Cvv",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
