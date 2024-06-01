import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_practicum/pages/Cart_Screen/Carts.dart';
import 'package:project_practicum/pages/Favorite_screen/MyFavorite.dart';
import 'package:project_practicum/pages/HomeScreen/Read.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Data extends StatefulWidget {
  final String imageUrl;
  final String titleBook;
  final String priceBook;
  final String description;
  final String publisher;
  final String authorBook;
  final String authorDecs;
  final int authorID;
  final String authorGender;
  final String authorImage;
  final String bookPdf;
  final int CategoryID;
  final String CategoryName;
  final int bookId; // Add bookId parameter to accept book_id

  const Data({
    required this.imageUrl,
    required this.titleBook,
    required this.priceBook,
    required this.description,
    required this.publisher,
    required this.authorBook,
    required this.authorDecs,
    required this.bookId,
    required this.authorID,
    required this.authorGender,
    required this.authorImage,
    required this.CategoryID,
    required this.CategoryName,
    required this.bookPdf, // Include bookId parameter
  });

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  bool showMore = false;
  bool addedToCart = false; // State variable to track whether item is added to cart
  bool addToFavorite = false;
  List<Map<String, dynamic>> recommendedBooks = [];

  @override
  void initState() {
    super.initState();
    fetchRecommendedBooksByAuthor(widget.authorBook);
  }

  // Function to retrieve the access token from SharedPreferences
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> fetchRecommendedBooksByAuthor(String authorBook) async {
    try {
      final accessToken = await _getAccessToken();

      if (accessToken == null) {
        print('Access token not found. Cannot fetch recommended books.');
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/books/book?author_name=$authorBook'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Filter out books with different author name
        final filteredBooks = responseData.where((book) => book['author']['author_name'] == authorBook).toList();

        setState(() {
          recommendedBooks = List<Map<String, dynamic>>.from(filteredBooks);
        });
      } else {
        print('Failed to fetch recommended books - Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  Future<void> addToFavorites() async {
    try {
      if (addToFavorite) {
        // If addToFavorite is already true, do not send the request again
        return;
      }

      setState(() {
        // Disable the button while the request is being processed
        addToFavorite = true;
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');
      final int? userId = prefs.getInt('user_id');

      if (accessToken == null || userId == null) {
        print('Access token or user ID not found. Cannot add to favorites.');
        return;
      }

      final Map<String, dynamic> data = {
        "user_id": userId,
        "book_id": widget.bookId,
      };

      final jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/events/userbook'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {
        print('Data added to favorites successfully');
        // Optionally, update the UI or perform any other actions upon successful addition
        // Check if the item is already added to favorites
        if (!addToFavorite) {
          // Set addedToFavorite to true to prevent duplicate SnackBar
          setState(() {
            addToFavorite = true;
          });
          // Show SnackBar to indicate successful addition to favorites
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Expanded(
                    child: Text('Item added to favorites'),
                  ),
                  Icon(Icons.check_circle_outline, color: Colors.white),
                ],
              ),
              backgroundColor: Colors.green.shade500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else if (response.statusCode == 400) {
        // Handle specific error cases if necessary
        print('Bad request - Error: ${response.body}');
      } else {
        // Handle other status codes
        print('Failed to add data to favorites. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        // Re-enable the button after request completion (successful or not)
        addToFavorite = false;
      });
    }
  }



  // Function to post Carts data
  Future<void> addToCarts() async {
    try {
      // Retrieve access token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        // Access token not found, handle the case accordingly
        print('Access token not found. Cannot add to cart.');
        return;
      }

      // Retrieve user_id from SharedPreferences
      final int? userId = prefs.getInt('user_id');

      if (userId == null) {
        // User is not signed in, handle the case accordingly
        print('User ID is null. Cannot add to favorites.');
        return;
      }

      // Prepare the data to send
      final Map<String, dynamic> data = {
        "user_id": userId,
        "book_id": widget.bookId,
        "quantity": 0,
      };

      // Print the data
      print('Data to be sent to server: $data');

      // Convert data to JSON
      final jsonData = jsonEncode(data);

      // Send POST request
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/events/cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonData,
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        // Data successfully added to cart
        print('Data added to Cart successfully');
        // Update state to reflect that item has been added to cart
        setState(() {
          addedToCart = true;
        });
        // Show SnackBar to indicate successful addition to cart
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Text('Item already added to cart'),
                ),
                Icon(Icons.check_circle_outline, color: Colors.white),
              ],
            ),
            backgroundColor: Colors.green.shade500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        // Error occurred
        print('Failed to add data to Cart. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        backgroundColor: Colors.green.shade300,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue.shade100,
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
                        Text(
                          'Title: ${widget.titleBook}',
                          style: TextStyle(
                            color: Colors.green.shade500,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Image.network(
                          widget.imageUrl,
                          width: 250,
                          height: 250,
                        ),
                      ],
                    ),
                  ),

                  // Rest of the content with white background
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //display pdf
                        Container(
                          margin: EdgeInsets.only(bottom: 8, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade500,
                          ),
                        ),
                        // Conditionally render buttons based on the price
                        widget.priceBook.toLowerCase() == 'free'
                            ? Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            // Read Now Button
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.red),
                                  ),
                                  onPressed: () {
                                    // Add the print statement here
                                    print('PDF URL: ${widget.bookPdf}'); // This will print the bookPdf URL to the console
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(

                                        builder: (context) => Read(
                                          pdfUrl: widget.bookPdf,

                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Read Now',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Add to Favorites Button
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 8),
                                child: TextButton(
                                  onPressed: () {
                                    addToFavorites();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Add to Favorites',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            : // Add to Cart Button
                        Center(
                          child: Container(
                            width: 250,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(
                                    Colors.green),
                              ),
                              onPressed: () {
                                addToCarts();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Book Id: ${widget.bookId}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // display publisher
                        SizedBox(height: 8),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Price of Book: ${widget.priceBook}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // display publisher
                        SizedBox(height: 8),
                        Text(
                          'Publisher: ${widget.publisher}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        // display author
                        SizedBox(height: 8),
                        Text(
                          'Author: ${widget.authorBook}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 8),
                        // Show description with at most 3 lines
                        Text(
                          widget.description,
                          maxLines: showMore ? null : 3,
                          overflow: showMore
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis, // Use TextOverflow.visible when showMore is true
                        ),

                        SizedBox(height: 8),
                        // Button to toggle between showing more or less text
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
                          margin: EdgeInsets.only(bottom: 10, left: 7),
                          child: Text(
                            recommendedBooks.isNotEmpty
                                ? 'Recommended by ${recommendedBooks[0]['author']['author_name']}'
                                : 'Recommended Books',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recommendedBooks.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Data(
                                            imageUrl: recommendedBooks[index]['book_image'],
                                            titleBook: recommendedBooks[index]['title'],
                                            priceBook: recommendedBooks[index]['price'],
                                            description: recommendedBooks[index]['description'],
                                            publisher: recommendedBooks[index]['publisher'],
                                            authorBook: recommendedBooks[index]['author']['author_name'],
                                            authorDecs: recommendedBooks[index]['author']['author_decs'],
                                            bookId: recommendedBooks[index]['id'],
                                            authorID: recommendedBooks[index]['author']['id'],
                                            authorGender: recommendedBooks[index]['author']['gender'],
                                            authorImage: recommendedBooks[index]['author']['author_image'],
                                            CategoryID: recommendedBooks[index]['category']['id'],
                                            CategoryName: recommendedBooks[index]['category']['name'],
                                            bookPdf: recommendedBooks[index]['book_pdf'],
                                          ),
                                      ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        recommendedBooks[index]['book_image'],
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        recommendedBooks[index]['title'],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
