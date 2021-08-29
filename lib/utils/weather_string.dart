import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';

class WeatherString {
  final String description;
  final String temperature;
  final String minTemperature;
  final String maxTemperature;
  final String humidity;
  final String windSpeed;
  final String country;
  final String city;

  factory WeatherString.fromModel(Weather w) {
    return WeatherString(
        description: w.description,
        temperature: w.temperature.toString(),
        minTemperature: w.minTemperature.toString(),
        maxTemperature: w.maxTemperature.toString(),
        humidity: w.humidity.toString(),
        windSpeed: w.windSpeed.toStringAsFixed(1),
        country: w.country,
        city: w.city);
  }

  WeatherString({
    required this.description,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.country,
    required this.city,
  });
}
