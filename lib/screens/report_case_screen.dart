import 'dart:convert';
import 'package:Sanket/widgets/snapshot.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'map_picker_screen.dart';
import 'package:http/http.dart' as http;

class ReportNewCaseScreen extends StatefulWidget {
  const ReportNewCaseScreen({super.key});

  @override
  State<ReportNewCaseScreen> createState() => _ReportNewCaseScreenState();
}

class _ReportNewCaseScreenState extends State<ReportNewCaseScreen> {
  String? _address;
  final List<String> _symptoms = [
    'Fever',
    'Diarrhoea',
    'Vomiting',
    'Rash',
    'Body Ache',
    'Cough',
  ];
  final Set<String> _selectedSymptoms = {};
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("reports");

  double? _lat;
  double? _lng;
  final TextEditingController _notesController = TextEditingController();

  // NEW: Severity & Duration
  String? _selectedSeverity;
  final TextEditingController _durationController = TextEditingController();
  final List<String> _severityOptions = ['Mild', 'Moderate', 'Severe'];

  // 🔹 Loading state for location
  bool _isLocating = false;

  // Get Current Location
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLocating = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled")),
      );
      setState(() => _isLocating = false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied")),
        );
        setState(() => _isLocating = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Location permissions are permanently denied."),
        ),
      );
      setState(() => _isLocating = false);
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _lat = pos.latitude;
        _lng = pos.longitude;
        _address = "Fetching address...";
      });

      await _getAddressFromLatLng(_lat!, _lng!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error getting location: $e")),
      );
    } finally {
      setState(() {
        _isLocating = false;
      });
    }
  }

  // Fetch human-readable address
  final String _apiKey = "pk.41dcf0fca1649876b25b11273d29ea01";
  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    final url =
        "https://us1.locationiq.com/v1/reverse?key=$_apiKey&lat=$lat&lon=$lng&format=json";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _address = data["display_name"];
        });
      } else {
        setState(() => _address = "Failed to fetch address");
      }
    } catch (e) {
      setState(() => _address = "Error: $e");
    }
  }

  // Choose from map
  Future<void> _chooseFromMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MapPickerScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _lat = result["lat"];
        _lng = result["lng"];
        _address = result["address"];
      });
    }
  }

  // Submit report
  Future<void> _submitReport() async {
    if (_lat == null || _lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a location first")),
      );
      return;
    }

    final newReportRef = _dbRef.push();
    await newReportRef.set({
      "latitude": _lat,
      "longitude": _lng,
      "symptoms": _selectedSymptoms.toList(),
      "severity": _selectedSeverity,
      "duration_days": _durationController.text,
      "notes": _notesController.text,
      "timestamp": DateTime.now().toIso8601String(),
      "address": _address,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Report Submitted!"),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      _selectedSymptoms.clear();
      _lat = null;
      _lng = null;
      _address = null;
      _notesController.clear();
      _durationController.clear();
      _selectedSeverity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Household details
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Household & Patient Details',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Household ID (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Symptoms
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Symptoms Checklist',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: _symptoms.map((s) {
                    return FilterChip(
                      label: Text(s),
                      selected: _selectedSymptoms.contains(s),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedSymptoms.add(s);
                          } else {
                            _selectedSymptoms.remove(s);
                          }
                        });
                      },
                      selectedColor: Colors.teal.shade100,
                      checkmarkColor: Colors.teal,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Severity & Duration
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Severity & Duration',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Severity",
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedSeverity,
                  items: _severityOptions.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedSeverity = val;
                    });
                  },
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Duration (in days)",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Location & Notes
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Location & Notes',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),

                if (_lat != null && _lng != null)
                  Column(
                    children: [
                      Text(
                        _address ?? "Fetching address...",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                if (_lat != null && _lng != null)
                  MapSnapshot(
                    lat: _lat!,
                    lng: _lng!,
                    apiKey: _apiKey,
                  ),

                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isLocating ? null : _getCurrentLocation,
                        icon: _isLocating
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.teal),
                                ),
                              )
                            : const Icon(Icons.my_location),
                        label: Text(_isLocating ? "Locating..." : "Current Location"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _chooseFromMap,
                        icon: const Icon(Icons.map_outlined),
                        label: const Text("Choose Map"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Additional Notes...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _submitReport,
          child: const Text(
            'SUBMIT REPORT',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
