import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherByLocation();
  Future<Either<Failure, Weather>> getWeatherByCityName(
    String city,
  );
}
