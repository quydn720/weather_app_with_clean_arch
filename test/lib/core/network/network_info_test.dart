import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_w_clean_architeture/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

// ignore: camel_case_types
class tInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

@GenerateMocks([], customMocks: [
  MockSpec<tInternetConnectionChecker>(as: #MockInternetConnectionChecker)
])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });
  test(
    'should forward the call to Geolocator.',
    () async {
      final tNetworkFuture = Future.value(true);

      // arrange
      when(mockInternetConnectionChecker.hasConnection).thenAnswer(
        (_) async => tNetworkFuture,
      );
      // act
      networkInfo.hasConnection;
      // assert
      verify(mockInternetConnectionChecker.hasConnection);
    },
  );
}
