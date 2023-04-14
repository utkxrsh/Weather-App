import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              weather.cityName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${weather.temperatureCelsius.toStringAsFixed(1)}°C',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Image.network(weather.iconUrl),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}