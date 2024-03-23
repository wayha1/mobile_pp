import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package
import 'package:project_practicum/pages/HomeScreen/Data.dart';
import 'package:project_practicum/pages/HomeScreen/information.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 260,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Information(
                        imageUrls: informationProvider2
                            .map<String>((item) => item['book_image'] ?? '')
                            .toList(),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'See all (Comic Books)',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
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
              ),
            ),
          ),
          SizedBox(
            height: 10, // Add margin here
          ),
          Container(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: informationProvider2.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.all(10.0),
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
                                    imageUrl: informationProvider2[index]
                                    ['book_image'] ?? '',
                                  ),
                                ),
                            );
                          },
                          child: Image.network(
                            informationProvider2[index]['book_image'] ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // Add spacing between image and text
                      Text(
                        informationProvider2[index]['title'] ?? '', // Display the name
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        informationProvider2[index]['price'] ?? '', // Display the price
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),



          //Container of comdy book
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Information(
                        imageUrls: informationProvider3
                            .map<String>((item) => item['book_image'] ?? '')
                            .toList(),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'See all (Comdy Books)',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
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
              ),
            ),
          ),
          SizedBox(
            height: 10, // Add margin here
          ),
          Container(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: informationProvider3.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.all(10.0),
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
                                  imageUrl: informationProvider3[index]
                                  ['book_image'] ?? '',
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            informationProvider3[index]['book_image'] ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // Add spacing between image and text
                      Text(
                        informationProvider3[index]['title'] ?? '', // Display the name
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        informationProvider3[index]['price'] ?? '', // Display the price
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),


        ],
      ),
    );
  }
}
