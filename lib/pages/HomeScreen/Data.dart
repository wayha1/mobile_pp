import 'package:flutter/material.dart';
import 'package:project_practicum/pages/HomeScreen/Read.dart';

class Data extends StatefulWidget {
  final String imageUrl;
  final String titleBook;
  final String priceBook;
  final String description;
  final String publisher;
  final int authorBook;
  // final String pdfUrl;

  const Data({
    required this.imageUrl,
    required this.titleBook,
    required this.priceBook,
    required this.description,
    required this.publisher,
    required this.authorBook,
    // required this.pdfUrl,
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
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text(
                  'Title: ${widget.titleBook}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Image.network(
                  widget.imageUrl,
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 8),

                //display pdf
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade500,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
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
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 10),
                    child: Text(
                      'Read Now',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Text(
                  'Price of Book: ${widget.priceBook}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                  maxLines: showMore ? null : 5,
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
        ),
      ),
    );
  }
}
