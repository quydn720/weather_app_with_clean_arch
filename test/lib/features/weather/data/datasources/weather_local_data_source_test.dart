import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_w_clean_architeture/core/error/exceptions.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/models/weather_model.dart';
import '../../../../../weather/fixture_reader.dart';
import 'weather_local_data_source_test.mocks.dart';

class tSharedPreferences extends Mock implements SharedPreferences {}

@GenerateMocks([],
    customMocks: [MockSpec<tSharedPreferences>(as: #MockSharedPreferences)])
void main() {
  late WeatherLocalDataSourceImpl local;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    local =
        WeatherLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group(
    'getLastWeather',
    () {
      final tWeatherModel =
          WeatherModel.fromJson(jsonDecode(fixture('weather_cached.json')));
      test(
        'should get the last weather from shared preferences if there have one',
        () async {
          // arrange
          when(mockSharedPreferences.getString(weatherKey))
              .thenReturn(fixture('weather_cached.json'));
          // act
          final result = await local.getLastWeather();
          // assert
          verify(mockSharedPreferences.getString(weatherKey));
          expect(result, tWeatherModel);
        },
      );

      test(
        'should throw a CacheException if there is not value cached',
        () async {
          // arrange
          when(mockSharedPreferences.getString(weatherKey)).thenReturn(null);
          // act
          final call = local.getLastWeather;
          // assert
          expect(() => call(), throwsA(TypeMatcher<CachedException>()));
        },
      );
    },
  );

  group(
    'cacheWeather',
    () {
      final tWeatherModel = WeatherModel(city: 'hcm', country: 'vn');

      test(
        'should call SharedPreferences to cache the data',
        () async {
          // act
          local.cacheWeather(tWeatherModel);
          // assert
          final expected = json.encode(tWeatherModel.toJson());
          verify(mockSharedPreferences.setString(
            weatherKey,
            expected,
          ));
        },
      );
    },
    skip: true,
  );
}
