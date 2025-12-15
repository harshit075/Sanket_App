import 'package:flutter/material.dart';
import 'package:Sanket/admin_dashboard/models/education_content.dart';

class EducationProvider extends ChangeNotifier {
  final List<EducationContent> _contents = [
    EducationContent(
      title: 'Video: The 5 Steps of Handwashing',
      details: 'Video • 3 min',
      type: 'Video',
      link: 'https://www.youtube.com/watch?v=3PmVJQUCm4E',
    ),
    EducationContent(
      title: 'Guide: How to Store Drinking Water Safely',
      details: 'Article • 5 min read',
      type: 'Article',
      link:
          'Always use clean containers, keep them covered, avoid sunlight exposure, and use within 24 hours.',
    ),
    EducationContent(
      title: 'Pamphlet: Why Boiling Water is Important',
      details: 'PDF • 1 page',
      type: 'PDF',
      link: 'https://www.who.int/publications/i/item/9241593997',
    ),

    // 🔹 New items
    EducationContent(
      title: 'Infographic: Symptoms of Dehydration',
      details: 'Image • Quick reference',
      type: 'Infographic',
      link:
          'https://www.cdc.gov/healthywater/emergency/pdf/infographic-dehydration.pdf',
    ),
    EducationContent(
      title: 'Checklist: Household Hygiene Essentials',
      details: 'Checklist • Printable',
      type: 'Checklist',
      link:
          'https://www.who.int/docs/default-source/wash-documents/checklist.pdf',
    ),
    EducationContent(
      title: 'Video: Safe Sanitation Practices',
      details: 'Video • 4 min',
      type: 'Video',
      link: 'https://www.youtube.com/watch?v=Yb727Wp0cOE',
    ),
    EducationContent(
      title: 'Guide: How to Purify Water with Chlorine',
      details: 'Article • 7 min read',
      type: 'Article',
      link:
          'Use chlorine tablets or liquid bleach in proper amounts. Wait 30 mins before drinking.',
    ),
  ];

  List<EducationContent> get contents => List.unmodifiable(_contents);

  void addContent(EducationContent content) {
    _contents.add(content);
    notifyListeners();
  }

  void removeContent(int index) {
    _contents.removeAt(index);
    notifyListeners();
  }
}
