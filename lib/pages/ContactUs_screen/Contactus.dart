import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/pages/SignIn_Screen/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_fonts/google_fonts.dart';

class Contactus extends StatefulWidget {
  final String username; // Add this line
  final String accessToken; // Add this line
  const Contactus({Key? key, required this.username, required this.accessToken}) : super(key: key); // Modify the constructor

  @override
  _ContactusState createState() => _ContactusState();
}

class _ContactusState extends State<Contactus>{

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? widget.accessToken;
    try {
      // Include JWT token in headers
      var response = await http.post(
        Uri.parse('http://10.0.2.2:5000/auth/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken', // Replace YOUR_JWT_TOKEN_HERE with the actual JWT token
        },
      );

      if (response.statusCode == 200) {
        // If successful logout, navigate to SignIn screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      } else {
        // Handle other status codes, if needed
        print('Error logging out: ${response.statusCode}');
      }
    } catch(e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        automaticallyImplyLeading: false, // Add this line
        title: Text(
          'Setting',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // First set of data
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          // Left side - Profile Avatar
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('lib/image/lo.png'), // Replace with your image path
                          ),
                          SizedBox(width: 10),

                          // Right side - Display Name Information
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Display Name:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    widget.username,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    ),

                    // White shadow box
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.blue,
                            width: 1,
                          ),

                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Left side - Profile Avatar (replace with your data)
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only( top: 20),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10, left: 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Display Name:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: _logout,
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}