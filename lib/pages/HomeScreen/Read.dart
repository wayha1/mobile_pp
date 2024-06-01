import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Read extends StatelessWidget {
  final String pdfUrl;
  const Read({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read'),
        backgroundColor: Colors.green.shade300,
      ),
      body: PDFView(
        filePath: pdfUrl,
        onError: (error) {
          print('Error loading PDF: $error');
        },
      ),

    );
  }
}
