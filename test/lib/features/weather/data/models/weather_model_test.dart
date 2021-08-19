import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/models/weather_model.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';

import '../../../../../weather/fixture_reader.dart';

void main() {
  final tWeatherModel = WeatherModel(
    city: 'Shuzenji',
    country: 'JP',
    description: 'overcast clouds',
    temperature: 295,
    minTemperature: 295,
    maxTemperature: 295,
    humidity: 92,
    dt: 1629379345,
    sunrise: 1629317216,
    sunset: 1629365328,
    windSpeed: 2.8,
  );
  test('should be a subclass of Weather entity ', () async {
    // assert
    expect(tWeatherModel, isA<Weather>());
  });

  group('fromJson', () {
    test('should return a valid model from Json', () async {
      // arrange
      final Map<String, dynamic> json = jsonDecode(fixture('response.json'));
      // act
      final result = WeatherModel.fromJson(json);
      // assert
      expect(result, tWeatherModel);
    });
  });

  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      // act
      final result = tWeatherModel.toJson();

      // assert
      final expected = {
        'city': 'Shuzenji',
        'country': 'JP',
        'description': 'overcast clouds',
        'temperature': 295,
        'minTemperature': 295,
        'maxTemperature': 295,
        'humidity': 92,
        'dt': 1629379345,
        'sunrise': 1629317216,
        'sunset': 1629365328,
        'windSpeed': 2.8,
      };
      expect(result, expected);
    });
  });
}
