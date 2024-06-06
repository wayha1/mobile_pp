import 'package:flutter/material.dart';
import 'package:project_practicum/pages/HomeScreen/Data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthorData extends StatefulWidget {
  final int authorId;
  final String authorName;
  final String authorDesc;
  final String authorGender;
  final String authorImage;

  const AuthorData({
    Key? key,
    required this.authorName,
    required this.authorDesc,
    required this.authorGender,
    required this.authorImage,
    required this.authorId,
  }) : super(key: key);

  @override
  State<AuthorData> createState() => _AuthorDataState();
}

class _AuthorDataState extends State<AuthorData> {
  bool showMore = false;
  List<Map<String, dynamic>> authorBooks = [];

  @override
  void initState() {
    super.initState();
    fetchRecommendedBooksByAuthor(widget.authorName);
  }

  // Function to retrieve the access token from SharedPreferences
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> fetchRecommendedBooksByAuthor(String authorName) async {
    try {
      final accessToken = await _getAccessToken();

      if (accessToken == null) {
        print('Access token not found. Cannot fetch recommended books.');
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/books/book?author_name=$authorName'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Filter out books with different author name
        final filteredBooks = responseData
            .where((book) => book['author']['author_name'] == authorName)
            .toList();

        setState(() {
          authorBooks = List<Map<String, dynamic>>.from(filteredBooks);
        });
      } else {
        print(
            'Failed to fetch recommended books - Status Code: ${response.statusCode}');
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade300, Colors.green.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        elevation: 10.0,
        shadowColor: Colors.green.withOpacity(0.8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10)
            )
        ),
        title: const Text(
          "Author's List",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade300,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  // TitleBook and Image section with background color and border radius
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80, // adjust size as needed
                          backgroundImage: NetworkImage(widget.authorImage),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Author's Name: ${widget.authorName}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Author's Gender: ${widget.authorGender}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Author's Id: ${widget.authorId}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            widget.authorDesc,
                            maxLines: showMore ? null : 3,
                            overflow: showMore
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showMore = !showMore;
                              });
                            },
                            child: Text(
                              showMore ? 'Show Less' : 'Show More',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), // Adjust the value to change the roundness
                              border: Border.all(
                                color: Colors.black, // Adjust the color as needed
                                width: 2, // Adjust the width as needed
                              ),
                            ),
                            margin: EdgeInsets.only(left: 10, bottom: 20),
                            child: Text(
                              "Author's book",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: authorBooks.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Data(
                                          imageUrl: authorBooks[index]['book_image'],
                                          titleBook: authorBooks[index]['title'],
                                          priceBook: authorBooks[index]['price'],
                                          description: authorBooks[index]['description'],
                                          publisher: authorBooks[index]['publisher'],
                                          authorBook: authorBooks[index]['author']['author_name'] ?? '',
                                          authorDecs: authorBooks[index]['author']['author_decs'] ?? '',
                                          bookId: authorBooks[index]['id'],
                                          authorID: authorBooks[index]['author']['id'] ?? 0,
                                          authorGender: authorBooks[index]['author']['gender'] ?? '',
                                          authorImage: authorBooks[index]['author']['author_image'] ?? '',
                                          CategoryID: authorBooks[index]['category']['id'] ?? 0,
                                          CategoryName: authorBooks[index]['category']['name'] ?? '',
                                          bookPdf: authorBooks[index]['book_pdf'] ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 8),
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          authorBooks[index]['book_image'],
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          authorBooks[index]['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
