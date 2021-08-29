import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_w_clean_architeture/core/error/failure.dart';
import 'package:weather_app_w_clean_architeture/core/validate/validator.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_city_name.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_location.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherByCityName getWeatherByCityName;
  final GetWeatherByLocation getWeatherByLocation;
  final InputValidator validator;
  WeatherBloc({
    required this.getWeatherByCityName,
    required this.getWeatherByLocation,
    required this.validator,
  }) : super(Empty());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherByCityNameEvent) {
      final input = validator.stringValidate(event.cityName);

      yield* input.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (validInput) async* {
          yield Loading();

          final result = await getWeatherByCityName(cityName: validInput);
          yield result.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (weather) => Loaded(weather),
          );
        },
      );
    } else if (event is GetWeatherByLocationEvent) {
      yield Loading();

      final result = await getWeatherByLocation();
      yield result.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (weather) => Loaded(weather),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case LocateFailure:
        return LOCATE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
