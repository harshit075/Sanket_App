import 'package:flutter/material.dart';

// Custom widget for a single alert card
class AlertCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final Color color;
  final IconData icon;

  const AlertCard({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$subtitle\n$time'),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
