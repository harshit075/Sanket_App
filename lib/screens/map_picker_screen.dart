import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng _pickedLocation = LatLng(26.2006, 92.9376); // Assam default
  String? _address;
  final String _apiKey = "pk.41dcf0fca1649876b25b11273d29ea01";

  // Fetch human-readable address from LocationIQ
  Future<void> _getAddressFromLatLng(LatLng pos) async {
    final url =
        "https://us1.locationiq.com/v1/reverse?key=$_apiKey&lat=${pos.latitude}&lon=${pos.longitude}&format=json";
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

  void _onMapTap(LatLng pos) {
    setState(() {
      _pickedLocation = pos;
      _address = "Fetching address...";
    });
    _getAddressFromLatLng(pos);
  }

  @override
  void initState() {
    super.initState();
    _getAddressFromLatLng(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Location")),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _pickedLocation,
              minZoom: 5,
              onTap: (tapPos, latlng) => _onMapTap(latlng),
            ),
            children: [
              TileLayer(
  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  subdomains: ['a', 'b', 'c'],
  userAgentPackageName: 'com.example.arogyasetuner',
),

              MarkerLayer(
                markers: [
                  Marker(
                    point: _pickedLocation,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Selected Location",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    "Lat: ${_pickedLocation.latitude}, Lng: ${_pickedLocation.longitude}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  if (_address != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _address!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 13, fontStyle: FontStyle.italic),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context, {
            "lat": _pickedLocation.latitude,
            "lng": _pickedLocation.longitude,
            "address": _address,
          });
        },
        icon: const Icon(Icons.check),
        label: const Text("Select"),
      ),
    );
  }
}
