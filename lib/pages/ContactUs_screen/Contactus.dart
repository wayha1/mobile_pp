import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/pages/HomeScreen/YourBook.dart';
import 'package:project_practicum/pages/SignIn_Screen/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_fonts/google_fonts.dart';

class Contactus extends StatefulWidget {
  final String username; // Add this line
  final String password;
  final String accessToken; // Add this line
  const Contactus({Key? key, required this.username, required this.accessToken, required this.password}) : super(key: key); // Modify the constructor

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
        Uri.parse('http://10.0.2.2:5000/authorization/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken', // Replace YOUR_JWT_TOKEN_HERE with the actual JWT token
        },
      );

      if (response.statusCode == 200) {
        // Show a snackbar to indicate successful logout
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Row(
            children: [
              Expanded(child: Text('logout successful'),
              ),
              Icon(Icons.logout, color: Colors.white,),
            ],
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          behavior: SnackBarBehavior.floating,),
        );

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
        automaticallyImplyLeading: false,
        leading: Center(
          child: Image.asset(
            'lib/image/logo.png',
            width: 50,
            height: 50,
            color: Colors.black,
          ),
        ),// Add this line
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
        child: SingleChildScrollView(
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
                          mainAxisAlignment: MainAxisAlignment.center, // Align items in the center horizontally
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage('lib/image/lo.png'), // Replace with your image path
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
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only( top: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10, left: 30),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Display Name:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Container(
                                                margin: EdgeInsets.only(left: 10),
                                                child: Text(
                                                  widget.username,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Password:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Container(
                                                margin: EdgeInsets.only(left: 10),
                                                child: Text(
                                                  widget.password,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: _logout,
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      backgroundColor: Colors.red.shade500
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 30, right: 30),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(margin: EdgeInsets.only(top: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        backgroundColor: Colors.blue.shade500
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => YourBook()
                                          ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 30, right: 30),
                                      child: Text(
                                        'Your Book',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),),
                        ],
                      ),
                    ],
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