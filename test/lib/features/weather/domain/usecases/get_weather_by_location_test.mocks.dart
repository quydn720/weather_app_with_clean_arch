// Mocks generated by Mockito 5.0.14 from annotations
// in weather_app_w_clean_architeture/test/lib/features/weather/domain/usecases/get_weather_by_location_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_app_w_clean_architeture/core/error/failure.dart' as _i5;
import 'package:weather_app_w_clean_architeture/features/weather/domain/entities/weather.dart'
    as _i6;

import 'get_weather_by_location_test.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [WeatherRepositoryT].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i3.WeatherRepositoryT {
  MockWeatherRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String toString() => super.toString();
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Weather>> getWeatherByLocation() =>
      (super.noSuchMethod(Invocation.method(#getWeatherByLocation, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.Weather>>.value(
                  _FakeEither_0<_i5.Failure, _i6.Weather>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Weather>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Weather>> getWeatherByCityName(
          String? city) =>
      (super.noSuchMethod(Invocation.method(#getWeatherByCityName, [city]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.Weather>>.value(
                  _FakeEither_0<_i5.Failure, _i6.Weather>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Weather>>);
}
