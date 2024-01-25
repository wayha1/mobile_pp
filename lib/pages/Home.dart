import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  const Account({Key? key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<Map<String, dynamic>> informationProvider = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080'));

    if (response.statusCode == 200) {
      setState(() {
        informationProvider = List<Map<String, dynamic>>.from(
          json.decode(response.body),
        );
      });
    } else {
      throw Exception('Failed to load data');
    }
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
          style: TextStyle(
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
      ),
      body: Center(
        child: informationProvider.isNotEmpty
            ? ListView.builder(
          itemCount: informationProvider.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(informationProvider[index]['name']),
              // You can also display the image if needed.
              // For example, Image.network(informationProvider[index]['image']),
            );
          },
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
