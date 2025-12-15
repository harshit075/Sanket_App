import 'package:flutter/material.dart';
import '../widgets/alert_card.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  int _selectedFilterIndex = 0;

  final List<Map<String, dynamic>> _alerts = [
    {
      "title": "Cholera Outbreak Alert",
      "subtitle": "Rampur Village",
      "time": "15 mins ago",
      "color": Colors.red,
      "icon": Icons.dangerous_outlined,
      "type": "Critical"
    },
    {
      "title": "Contaminated Water Source",
      "subtitle": "Hand Pump #3, Sitapur",
      "time": "2 hours ago",
      "color": Colors.orange,
      "icon": Icons.warning_amber_rounded,
      "type": "Warning"
    },
    {
      "title": "Upcoming Vaccination Drive",
      "subtitle": "Community Hall",
      "time": "1 day ago",
      "color": Colors.blue,
      "icon": Icons.info_outline,
      "type": "Info"
    },
  ];

  final List<String> _filters = ["All", "Critical", "Warning"];

  @override
  Widget build(BuildContext context) {
   
    final filteredAlerts = _selectedFilterIndex == 0
        ? _alerts
        : _alerts
            .where((alert) =>
                alert["type"] == _filters[_selectedFilterIndex])
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alerts"),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          // Filter buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ToggleButtons(
              isSelected: List.generate(
                  _filters.length, (index) => _selectedFilterIndex == index),
              onPressed: (index) {
                setState(() => _selectedFilterIndex = index);
              },
              borderRadius: BorderRadius.circular(8.0),
              fillColor: Theme.of(context).appBarTheme.shadowColor,
              selectedColor: Theme.of(context).appBarTheme.backgroundColor,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
              children: _filters
                  .map((filter) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(filter),
                      ))
                  .toList(),
            ),
          ),

         
          Expanded(
            child: filteredAlerts.isEmpty
                ? const Center(
                    child: Text(
                      "No alerts found",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    itemCount: filteredAlerts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final alert = filteredAlerts[index];
                      return AlertCard(
                        title: alert["title"],
                        subtitle: alert["subtitle"],
                        time: alert["time"],
                        color: alert["color"],
                        icon: alert["icon"],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
