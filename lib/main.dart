import 'package:flutter/material.dart';
import 'package:weather/models/weather_style_selector.dart';

import 'presentation/home_screen/home_screen.dart';

void main() {
  WeatherStyleSelector.initCurrentTime();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      home:
          HomeScreen(weatherStyle: WeatherStyleSelector.selectedWeatherStyle()),
    );
  }
}
