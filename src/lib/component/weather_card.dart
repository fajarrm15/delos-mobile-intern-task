import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:src/models/weather_model.dart';

const Map<int, String> dayMap = {
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun',
};

const Map<int, String> monthMap = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Des',
};

class WeatherCard extends StatelessWidget {
  const WeatherCard(
      {super.key, required this.weatherItem, required this.onTapWeather});

  final Weather weatherItem;
  final void Function(Weather weatherItem) onTapWeather;

  // Get Date from UTC to GMT+7
  String getDateTime(int dt) {
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000).toLocal();
    return '${dayMap[date.weekday]}, ${monthMap[date.month]} ${date.day}, ${date.year} ${date.hour % 12}:${date.minute < 10 ? '0${date.minute}' : date.minute} ${date.hour > 12 ? 'PM' : 'AM'}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        borderOnForeground: true,
        color: const Color.fromARGB(233, 226, 232, 247),
        child: InkWell(
          onTap: () {
            onTapWeather(weatherItem);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Image.network(
                    'https://openweathermap.org/img/wn/${weatherItem.image}@2x.png'),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getDateTime(weatherItem.date),
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      weatherItem.main,
                      style: GoogleFonts.montserrat(),
                    ),
                    Text(
                      'Temp: ${weatherItem.temp}\u00B0C',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
