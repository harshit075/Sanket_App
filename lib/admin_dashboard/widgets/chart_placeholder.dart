import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartPlaceholder extends StatelessWidget {
  const ChartPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with govt feel
            Row(
              children: const [
                Icon(Icons.assessment, color: Color(0xFF0A3D62)),
                SizedBox(width: 8),
                Text(
                  "Regional Risk Assessment",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A3D62), // Govt Blue
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Chart section
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 6,
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text("North");
                            case 1:
                              return const Text("South");
                            case 2:
                              return const Text("East");
                            case 3:
                              return const Text("West");
                          }
                          return const Text("");
                        },
                      ),
                    ),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                        toY: 4,
                        color: const Color(0xFFe74c3c), // Risk Red
                        width: 22,
                        borderRadius: BorderRadius.circular(6),
                      )
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                        toY: 5,
                        color: const Color(0xFFf39c12), // Warning Orange
                        width: 22,
                        borderRadius: BorderRadius.circular(6),
                      )
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(
                        toY: 2,
                        color: const Color(0xFF27ae60), // Safe Green
                        width: 22,
                        borderRadius: BorderRadius.circular(6),
                      )
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(
                        toY: 3,
                        color: const Color(0xFF2980b9), // Govt Blue
                        width: 22,
                        borderRadius: BorderRadius.circular(6),
                      )
                    ]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _LegendItem(color: Color(0xFFe74c3c), label: "High Risk"),
                _LegendItem(color: Color(0xFFf39c12), label: "Medium Risk"),
                _LegendItem(color: Color(0xFF27ae60), label: "Low Risk"),
                _LegendItem(color: Color(0xFF2980b9), label: "Stable"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({Key? key, required this.color, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
