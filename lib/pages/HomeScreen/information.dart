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
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Padding(
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
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        books[index]['book_image'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 8),
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
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


