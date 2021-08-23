import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_w_clean_architeture/core/location/location.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_location.dart';

import 'package:mockito/annotations.dart';
import 'get_weather_by_location_test.mocks.dart';

class WeatherRepositoryT extends Mock implements WeatherRepository {}

@GenerateMocks([],
    customMocks: [MockSpec<WeatherRepositoryT>(as: #MockWeatherRepository)])
void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetWeatherByLocation usecase;

  final tLocation = Location(lat: 1.0, lon: 1.0);

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherByLocation(
      mockWeatherRepository,
      tLocation,
    );
  });

  final tWeather = Weather(city: 'test', country: 'Viet Nam');

  test(
    'should get weather for the location of the device',
    () async {
      // arrange
      when(mockWeatherRepository.getWeatherByLocation(
        tLocation,
      )).thenAnswer((_) async => Right(tWeather));
      // act
      final result = await usecase();
      // assert
      expect(result, Right(tWeather));
      verify(
        mockWeatherRepository.getWeatherByLocation(tLocation),
      );
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
