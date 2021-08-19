import 'package:dartz/dartz.dart';
import 'package:weather_app_w_clean_architeture/core/error/failure.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherByCityName {
  final WeatherRepository weatherRepository;

  GetWeatherByCityName(this.weatherRepository);

  Future<Either<Failure, Weather>> call({required String cityName}) async {
    return await weatherRepository.getWeatherByCityName(cityName);
  }
}
