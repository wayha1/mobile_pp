import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/pages/Data.dart';
import 'package:project_practicum/pages/information.dart';

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
      final response1 = await http.get(Uri.parse('http://10.0.2.2:8080'));
      final response2 = await http.get(Uri.parse('http://10.0.2.2:8080/api/movie_information'));
      final response3 = await http.get(Uri.parse('http://10.0.2.2:8080/api/movie_information'));

      if (response1.statusCode == 200 && response2.statusCode == 200 && response3.statusCode == 200) {
        setState(() {
          informationProvider1 = List<Map<String, dynamic>>.from(
            json.decode(response1.body),
          );

          informationProvider2 = List<Map<String, dynamic>>.from(
            json.decode(response2.body),
          );

          informationProvider3 = List<Map<String, dynamic>>.from(
            json.decode(response3.body),
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
          Container(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: informationProvider1.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 400,
                        height: 200,
                        child: Image.network(
                          informationProvider1[index]['image'] ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                              informationProvider1[index]['name'] ?? '',
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
            ),
          ),

          //Comic
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
                        imageUrls: informationProvider2.map<String>((item) => item['image'] ?? '').toList(),
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Data(
                                    imageUrl: informationProvider2[index]['image'] ?? '',
                                  ),
                              ),
                            );
                          },
                          child: Image.network(
                            informationProvider2[index]['image'] ?? '',
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

          //Comedy
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
                        imageUrls: informationProvider3.map<String>((item) => item['image'] ?? '').toList(),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
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
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Data(
                                    imageUrl: informationProvider3[index]['image'] ?? '',
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              informationProvider3[index]['image'] ?? '',
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
          ),
        ],
      ),
    );
  }
}
