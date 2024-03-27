import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_practicum/pages/Cart_Screen/Carts.dart';
import 'package:project_practicum/pages/HomeScreen/Read.dart';

class Data extends StatefulWidget {
  final String imageUrl;
  final String titleBook;
  final String priceBook;
  final String description;
  final String publisher;
  final int authorBook;

  const Data({
    required this.imageUrl,
    required this.titleBook,
    required this.priceBook,
    required this.description,
    required this.publisher,
    required this.authorBook,
  });

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  bool showMore = false;

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
                        topRight: Radius.circular(30)
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Read(),
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
                                    // Handle add to favorites action
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
                                // Handle add to cart action
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>Carts(
                                            imageUrl: widget.imageUrl
                                        ),
                                    ),
                                );
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
                            'Price of Book: ${widget.priceBook}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // display publisher
                        SizedBox(height: 8,),
                        Text(
                          'Publisher: ${widget.publisher}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        // display publisher
                        SizedBox(height: 8,),
                        Text(
                          'Author: ${widget.authorBook}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: 8),
                        // Show description with at most 3 lines
                        Text(
                          widget.description,
                          maxLines: showMore ? null : 3,
                          overflow: showMore ? TextOverflow.visible : TextOverflow.ellipsis, // Use TextOverflow.visible when showMore is true
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
