import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({Key? key}) : super(key: key);

  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  late String responseData = '';

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
          responseData = response.body;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        automaticallyImplyLeading: false,
        title: Text('Favorite Screen'),
      ),
      body: Center(
        child: responseData.isNotEmpty
            ? Text(responseData)
            : CircularProgressIndicator(),
      ),
    );
  }
}
