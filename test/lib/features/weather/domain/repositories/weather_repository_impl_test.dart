import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_w_clean_architeture/core/error/exceptions.dart';
import 'package:weather_app_w_clean_architeture/core/error/failure.dart';
import 'package:weather_app_w_clean_architeture/core/location/location.dart';
import 'package:weather_app_w_clean_architeture/core/network/network.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/models/weather_model.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/repositories/weather_repository_impl.dart';

import 'package:mockito/annotations.dart';
import 'weather_repository_impl_test.mocks.dart';

class RemoteDataSource extends Mock implements WeatherRemoteDataSource {}

class LocalDataSource extends Mock implements WeatherLocalDataSource {}

class LocationInfoT extends Mock implements LocationInfo {}

class NetworkInfoT extends Mock implements NetworkInfo {}

@GenerateMocks([], customMocks: [MockSpec<NetworkInfoT>(as: #MockNetworkInfo)])
@GenerateMocks([],
    customMocks: [MockSpec<RemoteDataSource>(as: #MockRemoteDataSource)])
@GenerateMocks([],
    customMocks: [MockSpec<LocalDataSource>(as: #MockLocalDataSource)])
@GenerateMocks([],
    customMocks: [MockSpec<LocationInfoT>(as: #MockLocationInfo)])
void main() {
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;
  late MockLocationInfo mockLocationInfo;
  late MockNetworkInfo mockNetworkInfo;
  late WeatherRepositoryImpl repository;

  setUp(
    () {
      mockLocal = MockLocalDataSource();
      mockRemote = MockRemoteDataSource();
      mockLocationInfo = MockLocationInfo();
      mockNetworkInfo = MockNetworkInfo();
      repository = WeatherRepositoryImpl(
        localDataSource: mockLocal,
        remoteDataSource: mockRemote,
        locationInfo: mockLocationInfo,
        networkInfo: mockNetworkInfo,
      );
    },
  );

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group(
    'getWeatherByCityName',
    () {
      final tWeatherModel = WeatherModel(city: 'hcm', country: 'vn');
      final tCityName = 'hcm';
      final tWeather = tWeatherModel as Weather;
      test(
        'should check the network info if the user is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockRemote.getWeatherByCityName(tCityName))
              .thenAnswer((_) async => tWeatherModel);
          // act
          repository.getWeatherByCityName(tCityName);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );
      runTestOnline(
        () {
          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              // arrange
              when(mockRemote.getWeatherByCityName(tCityName))
                  .thenAnswer((_) async => tWeatherModel);
              // act
              final result = await repository.getWeatherByCityName(tCityName);
              // assert
              verify(mockRemote.getWeatherByCityName(tCityName));
              expect(result, equals(Right(tWeather)));
            },
          );
          test(
            'should cached the data locally when the call to remote data source is successful',
            () async {
              // arrange
              when(mockRemote.getWeatherByCityName(tCityName))
                  .thenAnswer((_) async => tWeatherModel);
              // act
              await repository.getWeatherByCityName(tCityName);
              // assert
              verify(mockRemote.getWeatherByCityName(tCityName));
              verify(mockLocal.cacheWeather(tWeatherModel));
            },
          );

          test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
              // arrange
              when(mockRemote.getWeatherByCityName(tCityName))
                  .thenThrow(ServerException());
              // act
              final result = await repository.getWeatherByCityName(tCityName);
              // assert
              verify(mockRemote.getWeatherByCityName(tCityName));
              verifyZeroInteractions(mockLocal);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );
      runTestOffline(
        () {
          test(
            'should return last locally cached data when the cached data is presented',
            () async {
              // arrange
              when(mockLocal.getLastWeather())
                  .thenAnswer((_) async => tWeatherModel);
              // act
              final result = await repository.getWeatherByCityName(tCityName);
              // assert
              verifyZeroInteractions(mockRemote);
              verify(mockLocal.getLastWeather());
              expect(result, equals(Right(tWeatherModel)));
            },
          );

          test(
            'should return cache failure when the cached data is not presented',
            () async {
              // arrange
              when(mockLocal.getLastWeather()).thenThrow(CachedException());
              // act
              final result = await repository.getWeatherByCityName(tCityName);
              // assert
              verifyZeroInteractions(mockRemote);
              verify(mockLocal.getLastWeather());
              expect(result, equals(Left(CacheFailure())));
            },
          );
        },
      );
    },
  );
  group('get weather by location', () {
    final tWeatherModel = WeatherModel(city: 'hcm', country: 'vn');
    final tLocation = Location(lat: 1.0, lon: 1.0);
    test(
      'should check the network info if the user is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockLocationInfo.location).thenAnswer((_) async => tLocation);
        when(mockRemote.getWeatherByLocation())
            .thenAnswer((_) async => tWeatherModel);
        // act
        await repository.getWeatherByLocation(tLocation);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    test(
      'should get the location',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockLocationInfo.location).thenAnswer((_) async => tLocation);
        when(mockRemote.getWeatherByLocation())
            .thenAnswer((_) async => tWeatherModel);
        // act
        repository.getWeatherByLocation(tLocation);
        // assert
        verify(mockNetworkInfo.isConnected);
        verify(mockLocationInfo.location);
      },
    );
    runTestOnline(() {
      test(
        'should return weather model with device location by calling the network data source, [successful]',
        () async {
          // arrange
          when(mockLocationInfo.location).thenAnswer((_) async => tLocation);
          when(mockRemote.getWeatherByLocation())
              .thenAnswer((_) async => tWeatherModel);
          // act
          final result = await repository.getWeatherByLocation(tLocation);
          // assert
          verify(mockRemote.getWeatherByLocation());
          expect(result, Right(tWeatherModel));
        },
      );

      test(
        'should cache the weather map to the local data source when calling the network data source, [successful]',
        () async {
          // arrange
          when(mockLocationInfo.location).thenAnswer((_) async => tLocation);
          when(mockRemote.getWeatherByLocation())
              .thenAnswer((_) async => tWeatherModel);
          // act
          await repository.getWeatherByLocation(tLocation);
          // assert
          verify(mockRemote.getWeatherByLocation());
          verify(mockLocal.cacheWeather(tWeatherModel));
        },
      );

      test(
        'should return server error if calling the network data source unsuccessful',
        () async {
          // arrange
          when(mockLocationInfo.location).thenAnswer((_) async => tLocation);
          when(mockRemote.getWeatherByLocation()).thenThrow(ServerException());
          // act
          final result = await repository.getWeatherByLocation(tLocation);
          // assert
          verifyZeroInteractions(mockLocal);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test(
        'should return last locally cached data when the cached data is presented',
        () async {
          // arrange
          when(mockLocationInfo.location).thenAnswer((_) async => tLocation);
          when(mockLocal.getLastWeather())
              .thenAnswer((_) async => tWeatherModel);
          // act
          final result = await repository.getWeatherByLocation(tLocation);
          // assert
          verifyZeroInteractions(mockRemote);
          verify(mockLocal.getLastWeather());
          expect(result, equals(Right(tWeatherModel)));
        },
      );

      test(
        'should return cache failure when the cached data is not presented',
        () async {
          // arrange
          when(mockLocationInfo.location).thenAnswer((_) async => tLocation);
          when(mockLocal.getLastWeather()).thenThrow(CachedException());
          // act
          final result = await repository.getWeatherByLocation(tLocation);
          // assert
          verifyZeroInteractions(mockRemote);
          verify(mockLocal.getLastWeather());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
