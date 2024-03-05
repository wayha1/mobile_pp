import 'package:flutter/material.dart';
import 'package:project_practicum/pages/Read.dart';

class Data extends StatelessWidget {
  final String imageUrl;

  const Data({required this.imageUrl}); // Update the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        backgroundColor: Colors.green.shade300,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Image.network(
                imageUrl,
                width: 300,
                height: 300,
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade500,
                ),
              ),
              TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Read(pdfUrl: 'https://drive.google.com/file/d/1XgeJar38zVC4Upt3vUeY3EPeaMLaxuHT/view?usp=drive_link')
                      ),
                  );
                },

                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  child: Text(
                    'Read Now',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
