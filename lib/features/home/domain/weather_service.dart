import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>?> fetchWeather(String cityName) async {
    final city = cityName.trim();

    if (city.isEmpty) return null;

    try {
      final geoUrl =
          "https://geocoding-api.open-meteo.com/v1/search?name=$city";

      final geoRes = await http.get(Uri.parse(geoUrl));
      final geoData = jsonDecode(geoRes.body);

      if (geoData['results'] == null) {
        return null;
      }

      final lat = geoData['results'][0]['latitude'];
      final lon = geoData['results'][0]['longitude'];

      final weatherUrl =
          "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true";

      final weatherRes = await http.get(Uri.parse(weatherUrl));
      final weatherJson = jsonDecode(weatherRes.body);

      return weatherJson['current_weather'];
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
