import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Search_Screen extends StatefulWidget {
  final String accessToken;
  const Search_Screen({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  Future<void> searchBooks(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? widget.accessToken;
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/books/book'), // Include the search query in the URL
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        setState(() {
          searchResults = List<Map<String, dynamic>>.from(
            json.decode(response.body),
          );
        });
      } else {
        print('Failed to search books - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to search books');
      }
    } catch (error) {
      print('Error searching books: $error');
    }
  }

  void clearSearchResults() {
    setState(() {
      searchResults.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Center(
          child: Text(
            'Search',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                color: Colors.grey[200], // Adjust background color as needed
                border: Border.all(
                  color: Colors.grey, // Set the border color
                  width: 2, // Set the border width
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  // Call searchBooks when the text field value changes
                  searchBooks(value);
                },
                onSubmitted: (value) {
                  // Clear search results when the user submits their search query
                  clearSearchResults();
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search), labelText: 'Find your Books here',
                  border: InputBorder.none, // Remove TextField border
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(searchResults[index]['title']),
                    leading: Image.network(searchResults[index]['book_image']),
                    onTap: () {
                      // Navigate to book details page or perform any other action
                    },
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

