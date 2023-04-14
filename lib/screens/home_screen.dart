import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/utils/api_key.dart';
import 'package:weather_app/widgets/weather_card.dart';
import 'package:weather_app/widgets/forecast_card.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cityNameController = TextEditingController();
  final _weatherProvider = WeatherProvider();
  Weather? _weather;
  List<Forecast>? _forecasts;

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter city name',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final cityName = _cityNameController.text.trim();
                final weather = await _weatherProvider.fetchWeather(cityName);
                final forecasts =
                    await _weatherProvider.fetchForecast(cityName);
                setState(() {
                  _weather = weather;
                  _forecasts = forecasts;
                });
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16),
            if (_weather != null) WeatherCard(weather: _weather!),
            const SizedBox(height: 16),
            if (_forecasts != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _forecasts!.length,
                  itemBuilder: (context, index) =>
                      ForecastCard(forecast: _forecasts![index]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
