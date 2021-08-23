import 'package:dartz/dartz.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_city_name.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetWeatherByCityName usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherByCityName(mockWeatherRepository);
  });

  final tCityName = 'Buon Ma Thuot';
  final tWeather = Weather(city: 'test', country: 'Viet Nam');

  test(
    'should get weather for the city name from the repository',
    () async {
      // arrange
      when(() => mockWeatherRepository.getWeatherByCityName(any()))
          .thenAnswer((_) async => Right(tWeather));
      // act
      final result = await usecase(cityName: tCityName);
      // assert
      expect(result, Right(tWeather));
      verify(
        () => mockWeatherRepository.getWeatherByCityName(tCityName),
      );
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
