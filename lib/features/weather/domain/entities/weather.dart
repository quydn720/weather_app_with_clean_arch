import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;
  final int temperature;
  final int minTemperature;
  final int maxTemperature;
  final int humidity;
  final double windSpeed;
  final String country;
  final String city;
  final int sunrise;
  final int sunset;
  final int dt;

  Weather(
      {this.description = '',
      this.temperature = 0,
      this.minTemperature = 0,
      this.maxTemperature = 0,
      this.humidity = 0,
      this.windSpeed = 0,
      this.country = '',
      this.city = '',
      this.sunrise = 0,
      this.sunset = 0,
      this.dt = 0});

  @override
  // Use city name & country to compare two Weather object
  List<Object?> get props => [country, city];
}
