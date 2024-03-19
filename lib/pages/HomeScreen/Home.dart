import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package
import 'package:project_practicum/pages/HomeScreen/Data.dart';
import 'package:project_practicum/pages/HomeScreen/information.dart';

class Account extends StatefulWidget {
  const Account({Key? key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<Map<String, dynamic>> informationProvider1 = [];
  List<Map<String, dynamic>> informationProvider2 = [];
  List<Map<String, dynamic>> informationProvider3 = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final jwtToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMDgzOTgyNiwianRpIjoiZTY4NDRlYjctZWMxMi00M2Y3LTg4NTktOTZlMDYyYzExMzExIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImFkbWluIiwibmJmIjoxNzEwODM5ODI2LCJjc3JmIjoiNzQ0NjkyNzQtZDlhNi00MTNmLWE3OTEtNTZjMzgyMGM2OTI4IiwiZXhwIjoxNzEwODQwNzI2fQ.IObEf_dC2m-SatIebHo-rGidxepA05ZV1AmZVnoN7V4'; // Replace with your actual JWT token
      final response1 = await http.get(
        Uri.parse('http://10.0.2.2:5000/books/book'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
        },
      );
      print('Response 1 Status Code: ${response1.statusCode}');
      print('Response 1 Body: ${response1.body}');

      if (response1.statusCode == 200) {
        setState(() {
          informationProvider1 = List<Map<String, dynamic>>.from(
            json.decode(response1.body),
          );
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      // Handle errors appropriately
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
          // Carousel Slider
          CarouselSlider(
            options: CarouselOptions(
              height: 260,
              enableInfiniteScroll: true, // Optional: Enable infinite scroll
              autoPlay: true, // Optional: Enable auto play
              onPageChanged: (index, reason) {

              },
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
                                style: GoogleFonts.playfairDisplay(
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



          // Container of Comic book
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                onPressed: () {
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
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 260,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Data(
                                  imageUrl: informationProvider2[index]
                                  ['book_image'] ??
                                      '',
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
                    ],
                  ),
                );
              },
            ),
          ),



          // Container of Comdy Book
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                onPressed: () {
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
                      'See all (Comedy Books)',
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
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 300,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Data(
                                  imageUrl: informationProvider3[index]
                                  ['book_image'] ??
                                      '',
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