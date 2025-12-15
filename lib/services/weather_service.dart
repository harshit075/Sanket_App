import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "2806bd8d3b2c1a04419c0efc372b7def"; 

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("WEATHER DATA: $data"); // 👈 Debug log
      return data;
    } else {
      throw Exception("Failed to load weather: ${response.body}");
    }
  }
}
