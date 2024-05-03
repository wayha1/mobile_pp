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

  Future<void> searchBookByTitle(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? widget.accessToken;
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/books/book/$title'), // Send title directly in URL path
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        setState(() {
          searchResults.clear(); // Clear existing search results
          searchResults.add(json.decode(response.body)); // Add the retrieved book to searchResults list
        });
      } else {
        print('Failed to search book by title - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to search book by title');
      }
    } catch (error) {
      print('Error searching book by title: $error');
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
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  // Pass the value to searchBookByTitle
                  searchBookByTitle(value);
                },
                onSubmitted: (value) {
                  clearSearchResults();
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      // Clear text field and search results when the clear icon is tapped
                      _searchController.clear();
                      clearSearchResults();
                    },
                  ),
                  labelText: 'Find your Books here',
                  border: InputBorder.none,
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
