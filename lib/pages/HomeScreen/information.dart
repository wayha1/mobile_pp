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
        title: Text('Information - $categoryName'),
        backgroundColor: Colors.green.shade300,
      ),
      body: Container(
        color: Colors.blue.shade50,
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
                              padding: EdgeInsets.only(top: 8.0, left: 30.0, right: 30.0, bottom: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50, // Background color
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 2.0, // Border width
                                ),// Rounded corners
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Title: ${books[index]['title']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Price: ${ books[index]['price']}',
                                    style: TextStyle(
                                      fontSize: 17,
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


