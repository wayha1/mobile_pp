import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contactus extends StatelessWidget {
  const Contactus({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text(
          'Setting',
          style: GoogleFonts.asapCondensed(
            fontSize: 25,
            color: Colors.white,

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            // First set of data
            Container(
              color: Colors.grey.shade100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                            style: GoogleFonts.asapCondensed(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Anonymous',
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade500,
                  width: 0.2,
                ),

              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side - Profile Avatar (replace with your data)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 40, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Display Name:',
                            style: GoogleFonts.asapCondensed(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Repeat the pattern for additional data sets as needed
          ],
        ),
      ),
    );
  }
}