import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_w_clean_architeture/core/error/exceptions.dart';

import '../models/weather_model.dart';

abstract class WeatherLocalDataSource {
  /// Get the cached [WeatherModel] which was gotten from the last time
  /// the user has internet connection
  ///
  /// Throws [NoLocalDataException] if no cached data is presented
  Future<WeatherModel> getLastWeather();

  Future<void> cacheWeather(WeatherModel weatherModel);
}

const weatherKey = 'CACHED_WEATHER';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheWeather(WeatherModel weatherModel) {
    return sharedPreferences.setString(
      weatherKey,
      json.encode(weatherModel.toJson()),
    );
  }

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(weatherKey);
    if (jsonString != null) {
      return Future.value(WeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CachedException();
    }
  }
}
