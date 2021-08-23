import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByCityName {
  final WeatherRepository weatherRepository;

  GetWeatherByCityName(this.weatherRepository);

  Future<Either<Failure, Weather>> call({required String cityName}) async {
    return await weatherRepository.getWeatherByCityName(cityName);
  }
}
