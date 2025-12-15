import 'package:flutter/material.dart';

class DownloadCard extends StatelessWidget {
  final String? selectedState;
  final String? selectedDistrict;
  final String? selectedWard;
  final Function(String?) onStateChanged;
  final Function(String?) onDistrictChanged;
  final Function(String?) onWardChanged;

  const DownloadCard({
    Key? key,
    required this.selectedState,
    required this.selectedDistrict,
    required this.selectedWard,
    required this.onStateChanged,
    required this.onDistrictChanged,
    required this.onWardChanged,
  }) : super(key: key);

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedState,
              decoration: _inputDecoration("State"),
              items: ["Mizoram", "Assam", "Nagaland"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: onStateChanged,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedDistrict,
              decoration: _inputDecoration("District"),
              items: ["West Siang", "Kamrup", "Aizawl"].map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
              onChanged: onDistrictChanged,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedWard,
              decoration: _inputDecoration("Ward"),
              items: ["Ward 1", "Ward 2", "Ward 3"].map((w) => DropdownMenuItem(value: w, child: Text(w))).toList(),
              onChanged: onWardChanged,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text("Download CSV"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
