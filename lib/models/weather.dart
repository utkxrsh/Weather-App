class Weather {
  final String cityName;
  final double temperatureCelsius;
  final String description;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.temperatureCelsius,
    required this.description,
    required this.iconCode,
  });

  String get iconUrl => 'https://openweathermap.org/img/w/$iconCode.png';
}
