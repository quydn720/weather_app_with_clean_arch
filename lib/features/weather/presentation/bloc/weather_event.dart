part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const <dynamic>[]]);
  @override
  List<Object?> get props => props;
}

class GetWeatherByLocationEvent extends WeatherEvent {}

class GetWeatherByCityNameEvent extends WeatherEvent {
  final String cityName;

  GetWeatherByCityNameEvent(this.cityName);
  @override
  List<Object?> get props => [cityName];
}
