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
      body: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              color: Colors.grey.withOpacity(0.5),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(
                    'lib/image/jisoo.jpg',
                    fit: BoxFit.fill,
                    width: 400,
                    height: 400,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.5),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(
                    'lib/image/jisoo.jpg',
                    fit: BoxFit.fill,
                    width: 400,
                    height: 400,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.5),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(
                    'lib/image/jisoo.jpg',
                    fit: BoxFit.fill,
                    width: 400,
                    height: 400,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.5),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(
                    'lib/image/jisoo.jpg',
                    fit: BoxFit.fill,
                    width: 400,
                    height: 400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
