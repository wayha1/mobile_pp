// information.dart
import 'package:flutter/material.dart';
import 'package:project_practicum/pages/HomeScreen/Data.dart';

class Information extends StatelessWidget {
  final List<String> imageUrls;

  Information({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          childAspectRatio: 0.7, // Adjust the aspect ratio as needed
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              height: 300, // Adjust the height as needed
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Data(
                        imageUrl: imageUrls[index],
                      ),
                    ),
                  );
                },
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.fill, // Use BoxFit.fill to fill the entire space
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
