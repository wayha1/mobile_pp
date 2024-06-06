// information.dart
import 'package:flutter/material.dart';
import 'package:project_practicum/pages/HomeScreen/Data.dart';

class Information extends StatelessWidget {
  final List<Map<String, dynamic>> books;
  final String categoryName;

  Information({required this.books, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName'),
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
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 15),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  height: 300,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Data(
                            imageUrl: books[index]['book_image'],
                            titleBook: books[index]['title'],
                            priceBook: books[index]['price'],
                            description: books[index]['description'],
                            publisher: books[index]['publisher'],
                            authorBook: books[index]['author']['author_name'],
                            authorDecs: books[index]['author']['author_decs'],
                            bookId: books[index]['id'],
                            authorID: books[index]['author']['id'],
                            authorGender: books[index]['author']['gender'],
                            authorImage: books[index]['author']['author_image'],
                            CategoryID: books[index]['category']['id'],
                            CategoryName: books[index]['category']['name'],
                            bookPdf: books[index]['book_pdf'],
                            //authorBook: books[index]['author_id'],
                            // pdfUrl: books[index]['book_pdf'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Expanded(
                                child: Image.network(
                                  books[index]['book_image'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.only(top: 8.0,left: 4.0, right: 30.0, bottom: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Title: ${books[index]['title']}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade500
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Price: ${ books[index]['price']} \$',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
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
              ),
            );
          },
        ),
      ),
    );
  }
}


