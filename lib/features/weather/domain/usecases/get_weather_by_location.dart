import 'package:dartz/dartz.dart';
import 'package:weather_app_w_clean_architeture/core/location/location.dart';
import '../../../../core/error/failure.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByLocation {
  final WeatherRepository weatherRepository;
  final Location location;
  GetWeatherByLocation(this.weatherRepository, this.location);

  Future<Either<Failure, Weather>> call() async {
    return await weatherRepository.getWeatherByLocation(location);
  }
}
