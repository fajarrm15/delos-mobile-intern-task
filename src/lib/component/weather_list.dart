import 'package:flutter/material.dart';
import 'package:src/component/weather_card.dart';
import 'package:src/screen/weather_detail.dart';

import '../models/weather_model.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({super.key, required this.listWeather});

  final List<Weather> listWeather;

  void selectWeather(BuildContext ctx, Weather weatherItem) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) => WeatherDetail(weatherItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listWeather.length,
      itemBuilder: (ctx, index) {
        return WeatherCard(
            weatherItem: listWeather[index],
            onTapWeather: (weather) {
              selectWeather(context, weather);
            });
      },
    );
  }
}
