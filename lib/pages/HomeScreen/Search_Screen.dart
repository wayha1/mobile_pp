import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/pages/HomeScreen/Data.dart';
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
        Uri.parse('http://10.0.2.2:5000/books/book/${Uri.encodeComponent(title)}'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = json.decode(response.body);
        if (responseBody.isNotEmpty) {
          setState(() {
            searchResults.clear(); // Clear existing search results
            searchResults.addAll(responseBody.map((item) => item as Map<String, dynamic>)); // Convert each item to Map<String, dynamic>
          });
        } else {
          print('No books found with the given title.');
        }
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
              )
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      //Map<String, dynamic> bookDetails = searchResults[index];
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Data(
                      //       imageUrl: searchResults[index]['book_image'] ?? '',
                      //       titleBook: searchResults[index]['title'] ?? '',
                      //       priceBook: searchResults[index]['price']?.toString() ?? '',
                      //       description: searchResults[index]['description'] ?? '',
                      //       publisher: searchResults[index]['publisher'] ?? '',
                      //       authorBook: searchResults[index]['author'] ?? '',
                      //       authorDecs: searchResults[index]['author_description'] ?? '',
                      //       bookId: searchResults[index]['book_id'] ?? '',
                      //       authorID: searchResults[index]['author_id'] ?? '',
                      //       authorGender: searchResults[index]['author_gender'] ?? '',
                      //       authorImage: searchResults[index]['author_image'] ?? '',
                      //       CategoryID: searchResults[index]['category_id'] ?? '',
                      //       CategoryName: searchResults[index]['category_name'] ?? '',
                      //       bookPdf: searchResults[index]['book_pdf'] ?? '',
                      //     ),
                      //   ),
                      // ).catchError((error) {
                      //   print('Error navigating to Data widget: $error');
                      // });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 80,
                            child: Image.network(
                              searchResults[index]['book_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10), // Add spacing between image and text
                          Expanded(
                            child: Text(
                              searchResults[index]['title'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
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
