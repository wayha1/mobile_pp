import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  String? accessToken;



  @override
  void initState() {
    super.initState();
    getAccessToken(); // Call getAccessToken in initState
  }

  Future<void> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token') ?? widget.accessToken;
    });
    print('Access Token: $accessToken'); // Print access token
    fetchData(); // Call fetchData after accessToken is fetched
  }

  Future<void> fetchData() async {
    try {
      final response1 = await http.get(
          Uri.parse('http://10.0.2.2:5000/books/book'),
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
        ],
      ),
    );
  }
}
