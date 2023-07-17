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
  bool retryFlag = false;
  String errorMessage = "";

  Future<void> _getWeather() async {
    // Retry if network error
    const int maxRetryCount = 2;
    int retryCount = 0;

    while (retryCount < maxRetryCount) {
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
        break;
      } catch (error) {
        errorMessage = error.toString();
      }

      retryCount++;
      await Future.delayed(const Duration(seconds: 1));
    }

    if (retryCount == maxRetryCount) {
      setState(() {
        retryFlag = true;
      });
    }
  }

  void _onClickRefresh() {
    setState(() {
      retryFlag = false;
    });
    _getWeather();
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
          ? (retryFlag
              ? Center(
                  child: ElevatedButton(
                    onPressed: _onClickRefresh,
                    child: const Text('Refresh'),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ))
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: WeatherList(listWeather: listWeatherData),
            ),
    );
  }
}
