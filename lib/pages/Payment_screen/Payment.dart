import 'package:flutter/material.dart';
import 'package:project_practicum/pages/Cart_Screen/Carts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  final String accessToken;
  const Payment({super.key, required this.accessToken});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {


  Future<void> paymentCarts() async {
    try{
      // Retrieve access token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

    }catch (error) {
      // Handle any errors
      print('Error: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text('Cancel', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade500,
          fontSize: 23,
        ),),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25, bottom: 10),
                  child: Text('Add To Card', style: TextStyle(
                    fontSize: 20,
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30, bottom: 10),
                  child: TextButton(
                    onPressed: () {
                      paymentCarts();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
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
                child: Text('Card', style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade500
                ),)
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              color: Colors.grey.shade300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                  labelText: "Credit Card",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}