import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
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
                        CircleAvatar(
                          radius: 80, // adjust size as needed
                          backgroundImage: NetworkImage(widget.authorImage),
                        ),
                      ],
                    ),
                  ),

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
                        Text(
                          "Author's Name: ${widget.authorName}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8), // Add some space between the two Text widgets
                        Text(
                          "Author's Gender: ${widget.authorGender}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8), // Add some space between the two Text widgets
                        Text(
                          "Author's Id: ${widget.authorId}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Show description with at most 3 lines
                        Text(
                          widget.authorDesc,
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
