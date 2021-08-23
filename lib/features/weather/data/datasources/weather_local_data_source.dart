import '../models/weather_model.dart';

abstract class WeatherLocalDataSource {
  /// Get the cached [WeatherModel] which was gotten from the last time
  /// the user has internet connection
  ///
  /// Throws [NoLocalDataException] if no cached data is presented
  Future<WeatherModel> getLastWeather();

  Future<void> cacheWeather(WeatherModel weatherModel);
}
