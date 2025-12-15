enum RiskLevel { high, medium, low }

class Hotspot {
  final String name;
  final String district;
  final RiskLevel risk;
  final int reports;

  Hotspot({
    required this.name,
    required this.district,
    required this.risk,
    required this.reports,
  });
}
