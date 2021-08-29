import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:weather_app_w_clean_architeture/core/error/failure.dart';
import 'package:weather_app_w_clean_architeture/core/location/location_info.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  /// Calls the https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

  /// Throws a [ServerException] for all errors code
  Future<Either<Failure, WeatherModel>> getWeatherByLocation(Location location);

  /// Calls the https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  /// Throws a [ServerException] for all errors code
  Future<Either<Failure, WeatherModel>> getWeatherByCityName(
    String city,
  );
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failure, WeatherModel>> getWeatherByCityName(
      String city) async {
    final url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=59a51238e8de109695c3a476a80429f2');
    final response = await client.get(url);
    final json = jsonDecode(response.body);
    if (json['cod'] == 200)
      return Right(WeatherModel.fromJson(json));
    else
      return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, WeatherModel>> getWeatherByLocation(
      Location location) async {
    final url = Uri.parse(
        'api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon={location.lon}&appid=59a51238e8de109695c3a476a80429f2');
    final response = await client.get(url);
    final json = jsonDecode(response.body);
    if (json['cod'] == 200)
      return Right(WeatherModel.fromJson(json));
    else
      return Left(ServerFailure());
  }
}
