import 'package:flutter/material.dart';

class EducationTile extends StatelessWidget {
  final String title;
  final String details;
  final String type;
  final String? link; // 👈 optional content link
  final VoidCallback? onRemove; // 👈 callback for delete
  final VoidCallback? onTap; // 👈 callback for opening/preview

  const EducationTile({
    super.key,
    required this.title,
    required this.details,
    required this.type,
    this.link,
    this.onRemove,
    this.onTap,
  });

  IconData _getIcon() {
    switch (type) {
      case "Video":
        return Icons.videocam;
      case "Article":
        return Icons.article;
      case "PDF":
        return Icons.picture_as_pdf;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getIconColor() {
    switch (type) {
      case "Video":
        return Colors.redAccent;
      case "Article":
        return Colors.green;
      case "PDF":
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(_getIcon(), color: _getIconColor(), size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(details),
        onTap: onTap, // 👈 open link/preview when tapped
        trailing: IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: "Remove",
        ),
      ),
    );
  }
}
