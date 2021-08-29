import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_w_clean_architeture/core/validate/validator.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_city_name.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_location.dart';
import 'package:weather_app_w_clean_architeture/features/weather/presentation/bloc/weather_bloc.dart';
import 'weather_bloc_test.mocks.dart';

class tGetWeatherByCityName extends Mock implements GetWeatherByCityName {}

class tGetWeatherByLocation extends Mock implements GetWeatherByLocation {}

class tInputValidator extends Mock implements InputValidator {}

@GenerateMocks([tGetWeatherByCityName])
@GenerateMocks([tGetWeatherByLocation])
@GenerateMocks([tInputValidator])
void main() {
  late WeatherBloc bloc;
  late MocktGetWeatherByCityName mockGetWeatherByCityName;
  late MocktGetWeatherByLocation mockGetWeatherByLocation;
  late MocktInputValidator mockInputValidator;

  setUp(
    () {
      mockInputValidator = MocktInputValidator();
      mockGetWeatherByCityName = MocktGetWeatherByCityName();
      mockGetWeatherByLocation = MocktGetWeatherByLocation();
      bloc = WeatherBloc(
        getWeatherByCityName: mockGetWeatherByCityName,
        getWeatherByLocation: mockGetWeatherByLocation,
        validator: mockInputValidator,
      );
    },
  );
  test(
    'initial state should be [Empty]',
    () async {
      // assert
      expect(bloc.state, equals(Empty()));
    },
  );

  group(
    'GetWeatherByCityName',
    () {
      final tCityName = 'hcm';
      final tValidatedCityName = tCityName;

      test(
        'should call the input validator to validate the string',
        () async {
          // arrange
          when(mockInputValidator.stringValidate(tCityName))
              .thenReturn(Right(tValidatedCityName));
          // act
          bloc.add(GetWeatherByCityNameEvent(tCityName));
          await untilCalled(mockInputValidator.stringValidate(tCityName));
          // assert
          verify(mockInputValidator.stringValidate(tCityName));
        },
      );

      test(
        'should emit [Error] when the input is invalid',
        () async {
          // arrange
          when(mockInputValidator.stringValidate(tCityName))
              .thenReturn(Left(InvalidInputFailure()));
          // act
          final expected = [
            Empty(),
            Error(message: INVALID_INPUT_FAILURE_MESSAGE),
          ];
          expectLater(bloc.state, emitsInOrder(expected));
          // assert
          bloc.add(GetWeatherByCityNameEvent(tCityName));
        },
        skip: true,
      );
    },
  );
}
