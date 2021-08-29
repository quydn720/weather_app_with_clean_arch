import 'package:dartz/dartz.dart';

import '../error/failure.dart';

class InputValidator {
  Either<Failure, String> stringValidate(String str) {
    bool validate = str.isNotEmpty;
    return validate ? Right(str) : Left(InvalidInputFailure());
  }
}

class InvalidInputFailure extends Failure {}
