class EducationContent {
  final String title;
  final String details;
  final String type; // Video, Article, PDF
  final String link; // YouTube, PDF URL, or Article text
  final bool isOffline;

  EducationContent({
    required this.title,
    required this.details,
    required this.type,
    required this.link,
    this.isOffline = true,
  });
}
