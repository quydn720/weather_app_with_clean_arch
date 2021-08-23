import 'package:dartz/dartz.dart';
import 'package:weather_app_w_clean_architeture/core/location/location.dart';
import '../../../../core/error/failure.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherByLocation(Location location);
  Future<Either<Failure, Weather>> getWeatherByCityName(
    String city,
  );
}
