import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Read extends StatelessWidget {
  const Read({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read'),
        backgroundColor: Colors.green.shade300,
      ),
      body: PDFView(
        filePath: "assets/Project_skinme.pdf", // Replace with your PDF file path
        // onPageChanged: (int page) {
        //   // Your logic for page change
        // },
      ),
    );
  }
}
