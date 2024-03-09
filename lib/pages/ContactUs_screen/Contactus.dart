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
        child: Padding(
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
                                    style: GoogleFonts.asapCondensed(
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
                          onPressed: () {
                            // Add your logout logic here
                          },
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
      ),
    );
  }
}