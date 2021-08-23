import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByLocation {
  final WeatherRepository weatherRepository;

  GetWeatherByLocation(this.weatherRepository);

  Future<Either<Failure, Weather>> call() async {
    return await weatherRepository.getWeatherByLocation();
  }
}
