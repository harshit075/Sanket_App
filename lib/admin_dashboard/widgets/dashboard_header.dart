import 'package:flutter/material.dart';
import 'stat_card.dart';

class DashboardHeader extends StatelessWidget {
  final int highRiskAreas;
  final String mostAffected;
  final int totalReports;
  final String lastUpdate;

  const DashboardHeader({
    Key? key,
    required this.highRiskAreas,
    required this.mostAffected,
    required this.totalReports,
    required this.lastUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        StatCard("High-Risk Areas", "$highRiskAreas", Icons.warning, Colors.red),
        StatCard("Most Affected", mostAffected, Icons.location_city, Colors.orange),
        StatCard("Total Reports", "$totalReports", Icons.bar_chart, Colors.teal),
        StatCard("Last Update", lastUpdate, Icons.update, Colors.grey),
      ],
    );
  }
}
