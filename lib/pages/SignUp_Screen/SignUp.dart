import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project_practicum/component/my_button_Bar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
  final _nickname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _gender = TextEditingController();
  bool _validateNickname = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateGender = false;

  Future<void> _signUp() async {
    setState(() {
      _validateNickname = _nickname.text.isEmpty;
      _validateEmail = _email.text.isEmpty;
      _validatePassword = _password.text.isEmpty;
      _validateGender = _gender.text.isEmpty;
    });

    if (!_validateNickname && !_validateEmail && !_validatePassword && !_validateGender) {
      final url = Uri.parse('http://10.0.2.2:5000/auth/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _nickname.text,
          'email': _email.text,
          'password': _password.text,
          'gender': _gender.text,
        }),
      );

      if (response.statusCode == 201) {
        // Authentication successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyButtomNavBar()),
        );
      }
      else {
        print("Authentication failed: ${response.statusCode}");
        // Authentication failed, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
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
          style: GoogleFonts.lora(
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
                  style: GoogleFonts.dancingScript(
                      fontSize: 15,
                      color: Colors.green.shade500
                  ),
                ),
              ),
              SizedBox(height: 8), // Add spacing between label and TextField
              TextField(
                controller: _nickname, // Add this line to assign the controller
                decoration: InputDecoration(
                  hintText: 'Enter Nickname',
                  errorText: _validateNickname ? 'Nickname cannot be empty' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 50),
                child: Text(
                  'Email Address *', // Your label text
                  style: GoogleFonts.dancingScript(
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
                  style: GoogleFonts.dancingScript(
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
              style: GoogleFonts.dancingScript(
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
                    style: GoogleFonts.crimsonText(
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
                      style: GoogleFonts.crimsonText(
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
                  style: GoogleFonts.arvo(
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
