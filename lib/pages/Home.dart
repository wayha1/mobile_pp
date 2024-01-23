import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Account extends StatefulWidget {
  const Account({Key? key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String name = '';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000'));

    final decoded = json.decode(response.body) as List<dynamic>;

    // Assuming there is only one item in the list
    if (decoded.isNotEmpty) {
      setState(() {
        name = decoded[0]['name'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        leading: Center(
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
        child: Column(
          children: [
            Text('Name: $name'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Account(),
  ));
}
