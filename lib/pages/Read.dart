import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';

class Read extends StatelessWidget {
  final String pdfUrl; // Add a parameter to receive the PDF URL

  const Read({required this.pdfUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read'),
        backgroundColor: Colors.green.shade300,
      ),
      body: SfPdfViewer.network(
        pdfUrl,
        canShowPaginationDialog: true,
      ),
    );
  }
}
