import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Sanket/admin_dashboard/provider/education_provider.dart';
import 'education_card.dart';
import 'article_detail_screen.dart';
import 'video_screen.dart';
import 'pdf_screen.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EducationProvider>(context);

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: provider.contents.length,
      itemBuilder: (context, index) {
        final content = provider.contents[index];
        IconData icon;
        Widget screen;

        if (content.type == "Video") {
          icon = Icons.videocam;
          screen = VideoScreen(title: content.title, youtubeUrl: content.link);
        } else if (content.type == "Article") {
          icon = Icons.article;
          screen = ArticleDetailScreen(title: content.title, content: content.link);
        } else {
          icon = Icons.picture_as_pdf;
          screen = PdfScreen(title: content.title, pdfUrl: content.link);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: EducationCard(
            title: content.title,
            details: content.details,
            isOffline: content.isOffline,
            icon: icon,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => screen),
              );
            },
          ),
        );
      },
    );
  }
}
