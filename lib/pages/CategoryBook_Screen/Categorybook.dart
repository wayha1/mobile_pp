import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryBook extends StatelessWidget {
  const CategoryBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        automaticallyImplyLeading: false, // Add this line
        title: Text(
            'Favorite',
        style: GoogleFonts.asapCondensed(
          fontSize: 25,
          color: Colors.black54,
        ),),
      ),
      body: Center(
        child: Text('This is the Store Screen'),
      ),
    );
  }
}
