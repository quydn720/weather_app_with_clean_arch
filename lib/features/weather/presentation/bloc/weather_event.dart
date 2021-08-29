part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeatherByLocationEvent extends WeatherEvent {}

class GetWeatherByCityNameEvent extends WeatherEvent {
  final String cityName;

  GetWeatherByCityNameEvent(this.cityName);
  @override
  List<Object?> get props => [cityName];
}
