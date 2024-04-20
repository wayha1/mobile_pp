import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package
import 'package:project_practicum/pages/HomeScreen/Data.dart';
import 'package:project_practicum/pages/HomeScreen/Search_Screen.dart';
import 'package:project_practicum/pages/HomeScreen/information.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Cart_Screen/Carts.dart';

class Account extends StatefulWidget {
  final String accessToken;

  const Account({required this.accessToken, Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<Map<String, dynamic>> informationProvider1 = [];
  List<Map<String, dynamic>> informationProvider2 = [];
  List<Map<String, dynamic>> informationProvider3 = [];

  String? accessToken;


  @override
  void initState() {
    super.initState();
    fetchData(); // Call getAccessToken in initState
  }

  Future<void> fetchData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? widget.accessToken;

      //response1
      final response1 = await http.get(
        Uri.parse('http://10.0.2.2:5000/books/book'),
        headers: {'Authorization': 'Bearer $accessToken'}, // Include access token in headers
      );

      if (response1.statusCode == 200) {
        final responseData = json.decode(response1.body);
        print('Response Body: $responseData'); // Print response body
        setState(() {
          informationProvider1 = List<Map<String, dynamic>>.from(
            responseData,
          );
        });
      } else {
        print('Failed to load data - Status Code: ${response1.statusCode}');
        print('Response Body: ${response1.body}');
        throw Exception('Failed to load data');
      }

      //response2
      final response2 = await http.get(
        Uri.parse('http://10.0.2.2:5000/books/book'),
        headers: {'Authorization': 'Bearer $accessToken'}, // Include access token in headers
      );

      if (response2.statusCode == 200) {
        final responseData = json.decode(response2.body);
        print('Response Body: $responseData'); // Print response body
        setState(() {
          informationProvider2 = List<Map<String, dynamic>>.from(
            responseData,
          );
        });
      } else {
        print('Failed to load data - Status Code: ${response2.statusCode}');
        print('Response Body: ${response2.body}');
        throw Exception('Failed to load data');
      }

      //response3
      final response3 = await http.get(
        Uri.parse('http://10.0.2.2:5000/books/book'),
        headers: {'Authorization': 'Bearer $accessToken'}, // Include access token in headers
      );

      if (response3.statusCode == 200) {
        final responseData = json.decode(response3.body);
        print('Response Body: $responseData'); // Print response body
        setState(() {
          informationProvider3 = List<Map<String, dynamic>>.from(
            responseData,
          );
        });
      } else {
        print('Failed to load data - Status Code: ${response3.statusCode}');
        print('Response Body: ${response3.body}');
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {

    // filter category 1
    // Filter category 1 books
    final comicBooks = informationProvider1.where((book) => book['category']['id'] == 1).toList();

// Filter category 2 books
    final comdyBooks = informationProvider1.where((book) => book['category']['id'] == 2).toList();


    List<Map<String, dynamic>> cartItems = [];

    // Function to add item to the cart
    void addToCart(Map<String, dynamic> item) {
      setState(() {
        cartItems.add(item); // Add the item to the cartItems list
      });
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
          'eLibrary',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Carts(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
          IconButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Search_Screen(accessToken: 'access_token',)),
                );
              },
              icon: Icon(Icons.search)
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: ListView(
          shrinkWrap: true,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 290,
                enableInfiniteScroll: true,
                autoPlay: true,
                onPageChanged: (index, reason) {},
              ),
              items: informationProvider1.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 400,

                            height: 200,
                            child: Image.network(
                              item['book_image'] ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Text(
                                  item['title'] ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),


            //Container of comic book
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'General Book',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Information(
                              books: comicBooks,
                              categoryName: 'Comic Books',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children to start and end of the row
                        children: [
                          Row(
                            children: [
                              Text(
                                'See',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green.shade500,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                                size: 17,
                              ),
                            ],
                          ),
                        ],
                      )

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10, // Add margin here
            ),
            Container(
              height: 380,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: comicBooks.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 260,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Data(
                                        imageUrl: comicBooks[index]
                                        ['book_image'] ?? '',
                                        titleBook: comicBooks[index]['title'] ?? '',
                                        priceBook: comicBooks[index]['price'] ?? ''.toString(),
                                        description: comicBooks[index]['description'] ?? '',
                                        publisher: comicBooks[index]['publisher'] ?? '',
                                        authorBook: comicBooks[index]['author']['author_name'] ?? '',
                                        bookId: comicBooks[index]['id'], // Pass book_id here
                                        // pdfUrl: comdyBooks[index]['book_pdf'],
                                      ),
                                    ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                                child: Image.network(
                                  comicBooks[index]['book_image'] ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8), // Add spacing between image and text
                          Container(
                            padding: EdgeInsets.only(top: 8.0, left: 30.0, right: 30.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50, // Background color
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 2.0, // Border width
                              ),// Rounded corners
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Title: ${comicBooks[index]['title'] ?? ''}', // Display the name
                                  style: TextStyle(
                                    color: Colors.green.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Price: ${comicBooks[index]['price'] ?? ''}\$', // Display the price with '$'
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
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

            SizedBox(
              height: 30, // Add margin here
            ),

            //Container of comdy book
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comdy Book',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Information(
                              books: comdyBooks,
                              categoryName: 'Comedy Books',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'See',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green.shade500,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                                size: 17,
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8, // Add margin here
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              height: 370,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: comdyBooks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: SizedBox(
                              width: 200,
                              height: 260,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Data(
                                        imageUrl: comdyBooks[index]['book_image'] ?? '',
                                        titleBook: comdyBooks[index]['title'] ?? '',
                                        priceBook: comdyBooks[index]['price'] ?? ''.toString(),
                                        description: comdyBooks[index]['description'] ?? '',
                                        publisher: comdyBooks[index]['publisher'] ?? '',
                                        authorBook: comdyBooks[index]['author']['author_name'] ?? '',
                                        bookId: comicBooks[index]['id'], // Pass book_id here
                                        // pdfUrl: comdyBooks[index]['book_pdf'],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                                  child: Image.network(
                                    comdyBooks[index]['book_image'] ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8.0, left: 30.0, right: 30.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50, // Background color
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 2.0, // Border width
                              ),// Rounded corners
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Title: ${comdyBooks[index]['title'] ?? ''}', // Display the name
                                  style: TextStyle(
                                    color: Colors.green.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Price: ${comdyBooks[index]['price'] ?? ''}\$', // Display the price with '$'
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
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
          ],
        ),
      ),
    );
  }
}


