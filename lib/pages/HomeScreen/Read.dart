import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Read extends StatefulWidget {
  const Read({Key? key}) : super(key: key);

  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read PDF'),
      ),
      body: SfPdfViewer.asset(
          "assets/pdf.pdf"
      ),
    );
  }
}
