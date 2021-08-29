import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_w_clean_architeture/core/validate/validator.dart';

void main() {
  late InputValidator inputValidator;

  setUp(() {
    inputValidator = InputValidator();
  });

  group(
    'validate city name',
    () {
      test(
        'should return an integer when the string represents an unsigned integer',
        () async {
          // arrange
          final city = 'hcm';
          // act
          final result = inputValidator.stringValidate(city);
          // assert
          expect(result, Right('hcm'));
        },
      );

      test(
        'should return an FormatFailure when the string is empty',
        () async {
          // arrange
          final city = '';
          // act
          final result = inputValidator.stringValidate(city);
          // assert
          expect(result, Left(InvalidInputFailure()));
        },
      );
    },
  );
}
