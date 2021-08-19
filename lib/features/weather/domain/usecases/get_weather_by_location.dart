import 'package:dartz/dartz.dart';
import 'package:weather_app_w_clean_architeture/core/error/failure.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/location.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherByLocation {
  final WeatherRepository weatherRepository;
  final Location location;

  GetWeatherByLocation(this.weatherRepository, {required this.location});

  Future<Either<Failure, Weather>> call() async {
    return await weatherRepository.getWeatherByLocation(
      lat: location.lat,
      lon: location.lon,
    );
  }
}
