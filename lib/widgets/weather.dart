import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/weather_service.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String? _temperature;
  String? _condition;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  Future<void> _getWeather() async {
    try {
      // Ask for location permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _loading = false;
          _condition = "Permission denied";
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      final weather = await WeatherService()
          .fetchWeather(position.latitude, position.longitude);

      setState(() {
  if (weather['main'] != null && weather['main']['temp'] != null) {
    _temperature = "${(weather['main']['temp']).round()}°C";
  } else {
    _temperature = "--";
  }

  if (weather['weather'] != null && weather['weather'].isNotEmpty) {
    _condition = weather['weather'][0]['main'];
  } else {
    _condition = "Unknown";
  }

  _loading = false;
});

    } catch (e) {
      setState(() {
        _loading = false;
        _condition = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    return Row(
      children: [
        Icon(
          _condition == "Clear"
              ? Icons.wb_sunny
              : _condition == "Clouds"
                  ? Icons.cloud
                  : Icons.water_drop,
          color: _condition == "Clear"
              ? Colors.amber
              : _condition == "Clouds"
                  ? Colors.blueGrey
                  : Colors.blue,
          size: 40,
        ),
        const SizedBox(width: 12),
        Text(
          _temperature ?? "--",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
