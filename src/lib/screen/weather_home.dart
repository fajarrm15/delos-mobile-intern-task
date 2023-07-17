import 'package:flutter/material.dart';
import 'package:src/models/weather_model.dart';
import 'package:src/component/weather_list.dart';

import '../services/weather_api.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  List<Weather> listWeatherData = [];
  String errorMessage = "";

  void _getWeather() async {
    try {
      final response = await WeatherService().fetchWeather();

      final List<Weather> loadedList = [];

      for (final item in response['list']) {
        loadedList.add(Weather(
          item['weather'][0]['icon'],
          item['dt'],
          item['weather'][0]['main'],
          item['weather'][0]['description'],
          (item['main']['temp'] - 273.15).toStringAsFixed(1),
          (item['main']['temp_min'] - 273.15).toStringAsFixed(1),
          (item['main']['temp_max'] - 273.15).toStringAsFixed(1),
        ));
      }

      setState(() {
        listWeatherData = loadedList;
      });
    } catch (error) {
      errorMessage = error.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Weather App',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 73, 148, 235),
      ),
      body: listWeatherData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: WeatherList(listWeather: listWeatherData),
            ),
      // backgroundColor: const Color.fromARGB(229, 244, 240, 244),
    );
  }
}
