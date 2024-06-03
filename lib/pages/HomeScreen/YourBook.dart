import 'package:flutter/material.dart';

class YourBook extends StatefulWidget {
  const YourBook({super.key});

  @override
  State<YourBook> createState() => _YourBookState();
}

class _YourBookState extends State<YourBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Book"),
      ),
    );
  }
}
