import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({Key? key}) : super(key: key);

  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  late List<dynamic> responseData = []; // Declare responseData as a list

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Retrieve access_token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        // Access token is not available, handle the case accordingly
        print('Access token is null. Cannot fetch data.');
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/events/userbook'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          // Parse the response body into a list of maps
          responseData = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Inside the build method
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        automaticallyImplyLeading: false,
        leading: Center(
          child: Image.asset(
            'lib/image/logo.png',
            width: 50,
            height: 50,
            color: Colors.black,
          ),
        ),
        title: Text('Favorite Screen'),
      ),
      body: responseData.isEmpty
          ? Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Stack(
            children: [
              // Image
              Image.asset(
                'assets/emptybox.png', // Replace with your image path
                width: 250, // Adjust width as needed
                height: 250, // Adjust height as needed
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 30),
                child: Text(
                  'No favorite items found.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ) : ListView.builder(
        itemCount: responseData.length,
        itemBuilder: (BuildContext context, int index) {
          final item = responseData[index];
          final bookTitle = item["book"]["title"];
          final bookImage = item["book"]["book_image"];
          return Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                Image.network(
                  bookImage,
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Title:\n ${bookTitle}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Add delete functionality here
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}