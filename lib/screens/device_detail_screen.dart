import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DeviceDetailScreen extends StatefulWidget {
  final String deviceName;

  const DeviceDetailScreen({super.key, required this.deviceName});

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  double batteryLevel = 75;

  Widget _buildGaugeCard({
    required String title,
    required IconData icon,
    required double min,
    required double max,
    required List<GaugeRange> ranges,
    required double value,
    required String valueText,
  }) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.teal.withOpacity(0.1),
                    child: Icon(icon, color: Colors.teal, size: 20),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  animationDuration: 1200,
                  axes: [
                    RadialAxis(
                      minimum: min,
                      maximum: max,
                      showTicks: false,
                      showLabels: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 12,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      ranges: ranges,
                      pointers: [
                        NeedlePointer(
                          value: value,
                          needleColor: Colors.teal,
                          needleLength: 0.7,
                          needleEndWidth: 4,
                          knobStyle: const KnobStyle(
                              knobRadius: 0.06, color: Colors.white),
                        ),
                      ],
                      annotations: [
                        GaugeAnnotation(
                          widget: Text(
                            valueText,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          angle: 90,
                          positionFactor: 1,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBatteryBar(double percentage) {
    Color color;
    if (percentage <= 20) {
      color = Colors.red;
    } else if (percentage <= 60) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Battery Level",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Container(
                  height: 25,
                  color: Colors.grey.shade300,
                ),
                Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width * (percentage / 100),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withOpacity(0.7),
                        color,
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "${percentage.toInt()}%",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deviceName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 4,
              runSpacing: 4,
              children: [
                _buildGaugeCard(
                  title: "pH Level",
                  icon: Icons.science,
                  min: 0,
                  max: 14,
                  value: 7.2,
                  valueText: "7.2",
                  ranges: [
                    GaugeRange(
                        startValue: 0,
                        endValue: 6.5,
                        color: Colors.red.shade400,
                        startWidth: 12,
                        endWidth: 12),
                    GaugeRange(
                        startValue: 6.5,
                        endValue: 8.5,
                        color: Colors.green.shade400,
                        startWidth: 12,
                        endWidth: 12),
                    GaugeRange(
                        startValue: 8.5,
                        endValue: 14,
                        color: Colors.orange.shade400,
                        startWidth: 12,
                        endWidth: 12),
                  ],
                ),
                _buildGaugeCard(
                  title: "TDS (ppm)",
                  icon: Icons.water_drop,
                  min: 0,
                  max: 1000,
                  value: 450,
                  valueText: "450 ppm",
                  ranges: [
                    GaugeRange(
                        startValue: 0,
                        endValue: 300,
                        color: Colors.green.shade400,
                        startWidth: 12,
                        endWidth: 12),
                    GaugeRange(
                        startValue: 300,
                        endValue: 600,
                        color: Colors.orange.shade400,
                        startWidth: 12,
                        endWidth: 12),
                    GaugeRange(
                        startValue: 600,
                        endValue: 1000,
                        color: Colors.red.shade400,
                        startWidth: 12,
                        endWidth: 12),
                  ],
                ),
                _buildGaugeCard(
                  title: "Temperature (°C)",
                  icon: Icons.thermostat,
                  min: 0,
                  max: 100,
                  value: 32,
                  valueText: "32°C",
                  ranges: [
                    GaugeRange(
                        startValue: 0,
                        endValue: 25,
                        color: Colors.blue.shade400,
                        startWidth: 12,
                        endWidth: 12),
                    GaugeRange(
                        startValue: 25,
                        endValue: 50,
                        color: Colors.green.shade400,
                        startWidth: 12,
                        endWidth: 12),
                    GaugeRange(
                        startValue: 50,
                        endValue: 100,
                        color: Colors.red.shade400,
                        startWidth: 12,
                        endWidth: 12),
                  ],
                ),
                _buildGaugeCard(
                  title: "Dissolved Oxygen (mg/L)",
                  icon: Icons.air,
                  min: 0,
                  max: 14,
                  value: 8.5,
                  valueText: "8.5 mg/L",
                  ranges: [
                    GaugeRange(
                        startValue: 0,
                        endValue: 4,
                        color: Colors.red.shade400,
                        startWidth: 12,
                        endWidth: 12),
                    GaugeRange(
                        startValue: 4,
                        endValue: 8,
                        color: Colors.orange.shade400,
                        startWidth: 12,
                        endWidth: 12),
                    GaugeRange(
                        startValue: 8,
                        endValue: 14,
                        color: Colors.green.shade400,
                        startWidth: 12,
                        endWidth: 12),
                  ],
                ),
              ],
            ),
            _buildBatteryBar(batteryLevel),
          ],
        ),
      ),
    );
  }
}
