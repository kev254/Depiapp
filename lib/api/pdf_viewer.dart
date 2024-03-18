import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

class PDFViewer extends StatefulWidget {
  final String pdfUrl;
  final String documents_name;

  PDFViewer({Key? key, required this.pdfUrl, required this.documents_name}) : super(key: key);

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  PDFViewController? _pdfViewController;
  bool _isLoading = true;
  String? _errorMessage;
  String filePath="https://academics.umw.edu/writing-fredericksburg/files/2011/09/Basic-Outlines.pdf";

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      final response = await http.get(Uri.parse(filePath));
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
      } else {
        print(response.body);
        throw 'Failed to load PDF: ${response.statusCode}';
      }
    } catch (error) {
      setState(() {
        print(_errorMessage);
        _isLoading = false;
        _errorMessage = 'Error loading PDF: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documents_name),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _errorMessage != null
          ? Center(
        child: Text(_errorMessage!),
      )
          : PDFView(
        filePath: filePath,
        onError: (error) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Error loading PDF: $error';
          });
        },
      ),
    );
  }
}
