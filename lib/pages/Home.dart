import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatelessWidget {
  const Account({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,

        leading: Center(

          // Adjust the margin as needed
          child: Image.asset(
            'lib/image/logo.png',
            width: 50,
            height: 50,
            color: Colors.black,

          ),
        ),
        title: Text(
          'eLibrary',
          style: GoogleFonts.asapCondensed(
            fontSize: 25,
            color: Colors.black54,
          ),
      ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your content goes here
            Text('This is the Account Screen'),
          ],
        ),
      ),
    );
  }
}
