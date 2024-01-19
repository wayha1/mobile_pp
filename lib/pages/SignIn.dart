import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_practicum/pages/SignUp.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

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
                    labelStyle: GoogleFonts.bitter(
                      fontSize: 15
                    ),
                  ),
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
                    labelStyle: GoogleFonts.bitter(
                        fontSize: 15
                    ),
                  ),
                ),
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 40, right: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 40, left: 10),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade600, // Adjust color as needed
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
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/image/fa.png',
                      width: 140,
                      height: 140,
                    ),
                    SizedBox(width: 10), // Add spacing between the images
                    Image.asset(
                      'lib/image/go.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
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
