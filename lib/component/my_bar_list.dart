import 'package:flutter/material.dart';

class MyBarList extends StatelessWidget {
  final String text;
  final IconData icon;

  const MyBarList({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(

      children: [
        ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}