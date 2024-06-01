import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

class Read extends StatefulWidget {
  final String pdfUrl;

  const Read({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  late String _accessToken; // Declare a variable to store the access token

  @override
  void initState() {
    super.initState();
    _getAccessToken(); // Call the function to retrieve access token when the widget initializes
  }

  // Function to retrieve the access token from SharedPreferences
  Future<void> _getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');

    if (accessToken != null) {
      setState(() {
        _accessToken = accessToken;
      });
    } else {
      // Handle the case where access token is not found
      print('Access token not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read'),
        backgroundColor: Colors.green.shade300,
      ),
      body: PDFView(
        filePath: widget.pdfUrl,
        onError: (error) {
          print('Error loading PDF: $error');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Failed to load PDF.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
