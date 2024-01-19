import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
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
                  'Email Address *', // Your label text
                  style: GoogleFonts.dancingScript(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 8), // Add spacing between label and TextField
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                  ),
                  hintText: 'Enter Email Address',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 10),
                child: Text(
                  'PASSWORD *', // Your label text
                  style: GoogleFonts.dancingScript(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 8), // Add spacing between label and TextField
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                  ),
                  hintText: 'Enter Password',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 10),
            child: Text(
              'Comfirm Password*', // Your label text
              style: GoogleFonts.dancingScript(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 8), // Add spacing between label and TextField
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
              hintText: 'Comfirm Password',
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
                onPressed: () {
                  // Add your onPressed logic here
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green.shade600, // Set the background color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
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
