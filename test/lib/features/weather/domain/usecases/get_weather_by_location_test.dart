import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_w_clean_architeture/core/location/location.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/location.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_location.dart';

class MockLocationHelper extends Mock implements LocationHelper {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late Location location;
  late MockWeatherRepository mockWeatherRepository;
  late GetWeatherByLocation usecase;
  setUp(() {
    location = Location(lat: 1.0, lon: 1.0);
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherByLocation(mockWeatherRepository, location: location);
  });

  final tLocation = Location(lat: 1.0, lon: 1.0);
  final tWeather = Weather(city: 'test', country: 'Viet Nam');

  test(
    'should get weather for the location of the device',
    () async {
      // arrange
      when(
        () => mockWeatherRepository.getWeatherByLocation(
          lat: any(named: "lat"),
          lon: any(named: "lon"),
        ),
      ).thenAnswer((_) async => Right(tWeather));
      // act
      final result = await usecase();
      // assert
      expect(result, Right(tWeather));
      verify(
        () => mockWeatherRepository.getWeatherByLocation(
          lat: tLocation.lat,
          lon: tLocation.lon,
        ),
      );
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
