import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_practicum/component/my_button_Bar.dart';
import 'package:project_practicum/pages/SignUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _validateUsername = false;
  bool _validatePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WELCOME TO OUR APP',
                        style: GoogleFonts.lobster(
                          fontSize: 20,
                          color: Colors.green.shade800,
                        ),
                      ),
                      Text(
                        'Sign up or log in to \nenjoy your time.',
                        style: GoogleFonts.asapCondensed(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10), // Add space between text and image
                Container(
                  width: 100, // Set the width of the image container
                  height: 100, // Set the height of the image container
                  child: Image.asset(
                    'lib/image/d.jpg', // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Add space between the Row and the TextField
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    labelText: "Email Address",
                    errorText: _validateUsername?'email cannot be null':null,
                    labelStyle: GoogleFonts.bitter(
                      fontSize: 15
                    ),
                  ),
                  controller: _username,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                    labelText: "Password",
                    errorText: _validatePassword?'password cannot be null':null,
                    labelStyle: GoogleFonts.bitter(
                        fontSize: 15
                    ),
                  ),
                  controller: _password,
                ),
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 40, right: 20),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _username.text.isEmpty?_validateUsername = true:_validateUsername = false;
                          _password.text.isEmpty?_validatePassword = true:_validatePassword = false;
                          if(_username.text == 'root' && _password.text == 'root'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyButtomNavBar()));
                          }
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade700, // Adjust color as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                      child: Text(
                        'SIGN IN',
                        style: GoogleFonts.slabo27px(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 40, left: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(150, 50),
                      ),
                      child: Text(
                        'SIGN UP',
                        style: GoogleFonts.slabo27px(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), // Add spacing between the button and the lines
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1, // Set the height of the line
                    color: Colors.grey, // Set the color of the line
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8 ,vertical: 8),
                  child: Text(
                    'OR login with',
                    style: GoogleFonts.indieFlower(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1, // Set the height of the line
                    color: Colors.grey, // Set the color of the line
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 130, top: 20),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      onPressed: () {
                        // Add your logic for Google login here
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        fixedSize: Size(400, 60),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/image/go.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Login with Google',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('cambodia',
                  style: GoogleFonts.breeSerif(
                    fontSize: 16,
                      color: Colors.grey.shade500
                  ),),
                  Text('E-Library Ltd.',
                    style: GoogleFonts.breeSerif(
                        fontSize: 16,
                        color: Colors.grey.shade500
                    ),),
                  Text('Tos Ran',
                    style: GoogleFonts.breeSerif(
                        fontSize: 16,
                      color: Colors.grey.shade500
                    ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
