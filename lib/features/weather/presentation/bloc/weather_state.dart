part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {}

class Empty extends WeatherState {
  @override
  List<Object> get props => [];
}

class Loading extends WeatherState {
  @override
  List<Object> get props => [];
}

class Loaded extends WeatherState {
  final Weather weather;

  Loaded(this.weather);
  @override
  List<Object> get props => [weather];
}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The city name cannot be empty.';

class Error extends WeatherState {
  final String message;
  Error({required this.message});
  @override
  List<Object?> get props => [message];
}
