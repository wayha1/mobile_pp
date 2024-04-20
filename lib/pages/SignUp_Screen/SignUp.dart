import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/component/my_button_Bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _gender = TextEditingController();
  bool _validateusername = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateGender = false;

  Future<void> _signUp() async {
    // Check if form fields are empty
    setState(() {
      _validateusername = _username.text.isEmpty;
      _validateEmail = _email.text.isEmpty;
      _validatePassword = _password.text.isEmpty;
      _validateGender = _gender.text.isEmpty;
    });

    if (!_validateusername &&
        !_validateEmail &&
        !_validatePassword &&
        !_validateGender) {
      // Extract form field values
      final username = _username.text;
      final email = _email.text;
      final password = _password.text;
      final gender = _gender.text;

      // Make POST request to register user
      final url = Uri.parse('http://10.0.2.2:5000/authorization/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'gender': gender,
        }),
      );

      // Check if registration was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response body
        final responseData = jsonDecode(response.body);

        // Extract access token and user information
        final accessToken = responseData['access_token'];
        final user = responseData['user'];

        // Extract user ID from user information
        final userId = user['id'];

        // Print user ID for debugging
        print('User ID: $userId');

        // Store the access token locally using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        await prefs.setInt('user_id', userId);

        // Navigate to the next screen (assuming MyButtomNavBar handles user ID)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyButtomNavBar(username: _username.text)),
        );
      } else {
        // Registration failed, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register. Please try again later.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text('Create eLibrary account',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 50, left: 15, right: 15),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'NickName *', // Your label text
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.green.shade500
                  ),
                ),
              ),
              SizedBox(height: 8), // Add spacing between label and TextField
              TextField(
                controller: _username, // Add this line to assign the controller
                decoration: InputDecoration(
                  hintText: 'Enter Nickname',
                  errorText: _validateusername ? 'Nickname cannot be empty' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 50),
                child: Text(
                  'Email Address *', // Your label text
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.green.shade500
                  ),
                ),
              ),
              SizedBox(height: 8), // Add spacing between label and TextField
              TextField(
                controller: _email, // Add this line to assign the controller
                decoration: InputDecoration(
                  hintText: 'Enter Email Address',
                  errorText: _validateEmail ? 'Email cannot be empty' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 10),
                child: Text(
                  'PASSWORD *', // Your label text
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.green.shade500
                  ),
                ),
              ),
              SizedBox(height: 8), // Add spacing between label and TextField
              TextField(
                controller: _password, // Add this line to assign the controller
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  errorText: _validatePassword ? 'Password cannot be empty' : null,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 10),
            child: Text(
              'Gender*', // Your label text
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.green.shade500
              ),
            ),
          ),
          SizedBox(height: 8), // Add spacing between label and TextField
          TextField(
            controller: _gender, // Add this line to assign the controller
            decoration: InputDecoration(
              hintText: 'Gender',
              errorText: _validateGender ? 'Gender cannot be empty' : null,
            ),
          ),

          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              child: Column(
                children: [
                  Text('By Sign up, I agree to the Terms Of Use and Privancy Policy of Our App.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text('E-Library collects and processes your email address for'
                        'making purpose. You can easily read the books and can buy the book'
                        'as wellwahtever you want to buy or read it.for Our App'
                        'You will get the good Book and good author as well. You can'
                        'search one ever you want when you want the book to read.THANK YOU!',
                      style:TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 50),
              child: TextButton(
                onPressed: _signUp,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green.shade600, // Set the background color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Adjust padding as needed
                ),
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    // You can add other text style properties here
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
