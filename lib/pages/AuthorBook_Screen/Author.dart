import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/pages/AuthorBook_Screen/AuthorData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorBook extends StatefulWidget {
  final String accessToken;
  const AuthorBook({required this.accessToken, Key? key}) : super(key: key);

  @override
  _AuthorBookState createState() => _AuthorBookState();
}

class _AuthorBookState extends State<AuthorBook> {
  List<dynamic> authors = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? widget.accessToken;

      // Make API call to fetch authors
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/author/author'),
        headers: {'Authorization': 'Bearer $accessToken'}, // Include access token in headers
      );

      if (response.statusCode == 200) {
        setState(() {
          authors = json.decode(response.body);
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
        backgroundColor: Colors.green.shade300,
        automaticallyImplyLeading: false,
        leading: Center(
          child: Image.asset(
            'lib/image/logo.png',
            width: 50,
            height: 50,
            color: Colors.black,
          ),
        ),// Add this line
        title: const Text(
          "Author's List",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: authors.length,
        itemBuilder: (context, index) {
          final author = authors[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorData(
                    authorName: author['author_name'],
                    authorDesc: author['author_decs'],
                    authorGender: author['gender'],
                    authorImage: author['author_image'],
                    authorId: author['id'], // Pass author's name to AuthorData
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 20.0, left: 20.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      author['author_image'],
                      width: 150, // Adjust the width to fit your UI requirements
                      height: 150, // Increase the height to fit your UI requirements
                      fit: BoxFit.cover, // Maintain aspect ratio while covering the entire space
                    ),
                  ),
                  SizedBox(width: 20), // Add spacing between image and text
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(author['author_name'], style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
