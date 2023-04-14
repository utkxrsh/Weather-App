import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/weather_card.dart';

class FavoritesScreen extends StatefulWidget {
  final List<String> cities;

  const FavoritesScreen({Key? key, required this.cities}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _weatherProvider = WeatherProvider();
  List<Weather>? _weathers;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _weathers == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _weathers!.length,
                itemBuilder: (context, index) => WeatherCard(weather: _weathers![index]),
              ),
      ),
    );
  }

  Future<void> _fetchWeatherData() async {
    final futures = widget.cities.map((city) => _weatherProvider.fetchWeather(city));
    final weathers = await Future.wait(futures);
    setState(() {
      _weathers = weathers;
    });
  }
}