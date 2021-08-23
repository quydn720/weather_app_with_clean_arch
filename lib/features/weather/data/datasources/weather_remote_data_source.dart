import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  /// Calls the https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

  /// Throws a [ServerException] for all errors code
  Future<WeatherModel> getWeatherByLocation();

  /// Calls the https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  /// Throws a [ServerException] for all errors code
  Future<WeatherModel> getWeatherByCityName(
    String city,
  );
}
