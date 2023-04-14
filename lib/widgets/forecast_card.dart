import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';

class ForecastCard extends StatelessWidget {
  final Forecast forecast;

  const ForecastCard({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forecast.weekday,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${forecast.temperatureCelsius.toStringAsFixed(1)}°C',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Image.network(forecast.iconUrl),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              forecast.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
