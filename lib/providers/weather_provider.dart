import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/utils/api_key.dart';

class WeatherProvider {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> fetchWeather(String cityName) async {
    final url = '$_baseUrl/weather?q=$cityName&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weather = Weather(
        cityName: data['name'],
        temperatureCelsius: data['main']['temp'].toDouble(),
        description: data['weather'][0]['description'],
        iconCode: data['weather'][0]['icon'],
      );
      return weather;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<List<Forecast>> fetchForecast(String cityName) async {
    final url = '$_baseUrl/forecast?q=$cityName&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final forecasts = List.generate(
        7,
        (index) => Forecast(
          weekday: _getWeekday(data['list'][index]['dt']),
          temperatureCelsius: data['list'][index]['main']['temp'].toDouble(),
          description: data['list'][index]['weather'][0]['description'],
          iconCode: data['list'][index]['weather'][0]['icon'],
        ),
      );
      return forecasts;
    } else {
      throw Exception('Failed to fetch forecast data');
    }
  }

  String _getWeekday(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final weekday = date.weekday;
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
