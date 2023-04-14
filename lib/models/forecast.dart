class Forecast {
  final String weekday;
  final double temperatureCelsius;
  final String description;
  final String iconCode;

  Forecast({
    required this.weekday,
    required this.temperatureCelsius,
    required this.description,
    required this.iconCode,
  });

  String get iconUrl => 'https://openweathermap.org/img/w/$iconCode.png';
}
