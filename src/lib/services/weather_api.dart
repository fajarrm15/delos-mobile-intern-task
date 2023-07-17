import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  Future<dynamic> fetchWeather() async {
    final response = await http
        .get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=-6.175&lon=106.8&appid=33a86c5d628c8ed63e721f473d2a106e',
        ))
        .timeout(const Duration(seconds: 1));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
