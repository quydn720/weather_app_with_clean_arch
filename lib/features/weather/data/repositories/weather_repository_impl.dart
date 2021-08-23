import 'package:weather_app_w_clean_architeture/core/error/exceptions.dart';

import '../../../../core/location/location.dart';
import '../../../../core/network/network.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_data_source.dart';
import '../../domain/entities/weather.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherLocalDataSource localDataSource;
  final WeatherRemoteDataSource remoteDataSource;
  final LocationInfo locationInfo;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.locationInfo,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getWeatherByCityName(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final weather = await remoteDataSource.getWeatherByCityName(city);
        localDataSource.cacheWeather(weather);
        return Right(weather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getLastWeather());
      } on CachedException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeatherByLocation(
      Location location) async {
    locationInfo.location;
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final weather = await remoteDataSource.getWeatherByLocation();
        localDataSource.cacheWeather(weather);
        return Right(weather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getLastWeather());
      } on CachedException {
        return Left(CacheFailure());
      }
    }
  }
}
