import 'package:flutter/material.dart';

/// A reusable card widget for displaying educational content.
class EducationCard extends StatelessWidget {
  final String title;
  final String details;
  final bool isOffline;
  final IconData icon;
  final VoidCallback? onTap;

  const EducationCard({
    super.key,
    required this.title,
    required this.details,
    required this.isOffline,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 36,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      details,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              if (isOffline)
                const Icon(
                  Icons.download_done,
                  color: Colors.teal,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
