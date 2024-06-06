import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/pages/HomeScreen/Read.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyFavorite extends StatefulWidget {
  final String accessToken;
  const MyFavorite({Key? key, required this.accessToken}) : super(key: key);

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

  // Function to show a confirmation dialog
  Future<void> showDeleteConfirmationDialog(BuildContext context, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                // Show a loading indicator after a short delay
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade400), // Customize the color here
                      ),
                    );
                  },
                );
                // Add a short delay to ensure the loading indicator is displayed
                await Future.delayed(Duration(milliseconds: 1000));
                // Call the function to delete the item
                await deleteItem(index);
                // Fetch data again to update the UI
                await fetchData();
                // Close the loading indicator dialog
                Navigator.of(context).pop();
                // Close the confirmation dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to delete the item
  Future<void> deleteItem(int index) async {
    try {
      final item = responseData[index];
      final int itemId = item['id'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? widget.accessToken;

      final response = await http.delete(
        Uri.parse('http://10.0.2.2:5000/events/userbook/$itemId'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 204) {
        // Remove the deleted item from the responseData list
        setState(() {
          responseData.removeAt(index);
        });
      } else {
        // Handle error
        print('Failed to delete item');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    // Inside the build method
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
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
        automaticallyImplyLeading: false,
        leading: Center(
          child: Image.asset(
            'lib/image/logo.png',
            width: 50,
            height: 50,
            color: Colors.black,
          ),
        ),
        title: Text('My Books'),
      ),
      body: responseData.isEmpty
          ? Center(
        child: Container(
          margin: EdgeInsets.only(top: 50, bottom: 30),
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
                margin: EdgeInsets.only(left: 30),
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
                Container(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Read()));
                    },
                    child: Image.network(
                      bookImage,
                      width: 150, // Adjust width as needed
                      height: 150, // Adjust height as needed
                    ),
                  ),
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
                    showDeleteConfirmationDialog(context, index);
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