import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List props = const <dynamic>[]]);
  // If the failure has some properties, they'll passed to the constructor
  // so the Equatable can figure how to comparision.
  @override
  List<Object?> get props => props;
}
