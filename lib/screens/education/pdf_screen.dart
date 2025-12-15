import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfScreen extends StatelessWidget {
  final String title;
  final String pdfUrl;

  const PdfScreen({
    super.key,
    required this.title,
    required this.pdfUrl,
  });

  Future<void> _launchPdf() async {
    final uri = Uri.parse(pdfUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $pdfUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.download),
          label: const Text("Download PDF"),
          onPressed: _launchPdf,
        ),
      ),
    );
  }
}
