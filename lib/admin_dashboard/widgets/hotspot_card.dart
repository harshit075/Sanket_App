import 'package:flutter/material.dart';
import '../models/hotspot.dart';

class HotspotCard extends StatelessWidget {
  final Hotspot hotspot;

  const HotspotCard({Key? key, required this.hotspot}) : super(key: key);

  Color _riskColor(RiskLevel r) {
    switch (r) {
      case RiskLevel.high:
        return Colors.red;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.low:
        return Colors.green;
    }
  }

  String _riskText(RiskLevel r) {
    switch (r) {
      case RiskLevel.high:
        return "High";
      case RiskLevel.medium:
        return "Medium";
      case RiskLevel.low:
        return "Low";
    }
  }

  @override
  Widget build(BuildContext context) {
    final riskColor = _riskColor(hotspot.risk);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        title: Text(
          hotspot.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          hotspot.district,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min, // 🔥 FIXED: prevents overflow
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Chip(
              label: Text(_riskText(hotspot.risk)),
              backgroundColor: riskColor.withOpacity(0.2),
              labelStyle: TextStyle(
                color: riskColor,
                fontWeight: FontWeight.bold,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // keeps chip compact
            ),
            const SizedBox(height: 4),
            Text(
              "Reports: ${hotspot.reports}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
