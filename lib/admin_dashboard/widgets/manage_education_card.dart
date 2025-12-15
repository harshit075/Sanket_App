import 'package:flutter/material.dart';

class ManageEducationCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController detailsController;
  final TextEditingController linkController; // 👈 added link field
  final String? selectedType; // 👈 added selected type
  final ValueChanged<String?> onTypeChanged;
  final VoidCallback onAddContent;
  final VoidCallback? onRemoveContent;

  const ManageEducationCard({
    super.key,
    required this.titleController,
    required this.detailsController,
    required this.linkController, // 👈 required
    required this.selectedType, // 👈 required
    required this.onTypeChanged,
    required this.onAddContent,
    this.onRemoveContent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage Education Content",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(
                labelText: "Details (duration, pages, etc.)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: linkController,
              decoration: const InputDecoration(
                labelText: "Link (YouTube, PDF, etc.)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedType, // 👈 keep selected value
              decoration: const InputDecoration(
                labelText: "Content Type",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Video", child: Text("Video")),
                DropdownMenuItem(value: "Article", child: Text("Article")),
                DropdownMenuItem(value: "PDF", child: Text("PDF")),
              ],
              onChanged: onTypeChanged,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onRemoveContent != null)
                  OutlinedButton.icon(
                    onPressed: onRemoveContent,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: onAddContent,
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
