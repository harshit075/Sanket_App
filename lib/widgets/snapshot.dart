import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapSnapshot extends StatelessWidget {
  final double lat;
  final double lng;
  final String apiKey;

  const MapSnapshot({
    super.key,
    required this.lat,
    required this.lng,
    required this.apiKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(lat, lng),
            minZoom: 5,
            maxZoom: 18,
            interactionOptions: const InteractionOptions(
      flags: InteractiveFlag.none, // disables dragging, zooming, rotation
    ),


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
                  point: LatLng(lat, lng),
                  width: 40,
                  height: 40,
                  child:  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 36,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
