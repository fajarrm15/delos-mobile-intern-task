import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_model.dart';

const Map<int, String> dayMap = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wedbesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};

const Map<int, String> monthMap = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

class WeatherDetail extends StatelessWidget {
  const WeatherDetail(this.weather, {super.key});

  final Weather weather;

  // Get date from UTC to GMT+7
  String getDateTime(int dt) {
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000).toLocal();
    return '${dayMap[date.weekday]}, ${monthMap[date.month]} ${date.day}, ${date.year}';
  }

  // Get time from UTC to GMT+7
  String getHour(int dt) {
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000).toLocal();
    return '${date.hour % 12}:${date.minute < 10 ? '0${date.minute}' : date.minute} ${date.hour > 12 ? 'PM' : 'AM'}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Details',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 73, 148, 235),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(245, 234, 236, 241),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
                child: Text(
              getDateTime(weather.date),
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            )),
            Center(
              child: Text(
                getHour(weather.date),
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${weather.temp}\u00B0C',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.image}@4x.png',
                  scale: 1.5,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                '${weather.main} (${weather.desc})',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Temp (min)',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${weather.tempmin}\u00B0C',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Temp (max)',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${weather.tempmax}\u00B0C',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
