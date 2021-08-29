import 'package:weather_app_w_clean_architeture/core/error/exceptions.dart';

import '../../../../core/location/location_info.dart';
import '../../../../core/network/network_info.dart';
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
    if (await networkInfo.hasConnection) {
      try {
        final weather = await remoteDataSource.getWeatherByCityName(city);
        return weather.fold(
          (l) => throw ServerException(),
          (r) {
            localDataSource.cacheWeather(r);
            return Right(r);
          },
        );
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
  Future<Either<Failure, Weather>> getWeatherByLocation() async {
    if (await networkInfo.hasConnection) {
      try {
        final weather = await remoteDataSource.getWeatherByLocation(
          await locationInfo.location,
        );
        return weather.fold(
          (l) => throw ServerException(),
          (r) {
            localDataSource.cacheWeather(r);
            return Right(r);
          },
        );
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
