import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Carts extends StatelessWidget {
  const Carts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text(
            'Carts',
        style: GoogleFonts.acme(
          fontSize: 25,
          color: Colors.black54,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.shopping_cart_outlined),
              color: Colors.white,
              iconSize: 30,),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.search_outlined),
              color: Colors.white,
            iconSize: 30,),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(

        ),
      ),
    );
  }
}
