import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/models/weather_model.dart';

import '../../../../../weather/fixture_reader.dart';
import 'weather_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late WeatherRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSource = WeatherRemoteDataSourceImpl(mockHttpClient);
  });

  group(
    'getWeatherByCityName',
    () {
      final tUrl = Uri.parse('open.com');
      final tCityName = 'hcm';
      test(
        'should perform a get request on a URL with city name, then return a WeatherModel if [successful]',
        () async {
          // arrange
          when(mockHttpClient.get(tUrl)).thenAnswer(
              (_) async => http.Response(fixture('response.json'), 200));
          // act
          remoteDataSource.getWeatherByCityName(tCityName);
          // assert
          expect(await remoteDataSource.getWeatherByCityName(tCityName),
              isA<WeatherModel>());
        },
      );
    },
    skip: true, //TODO: Just don't know how to mock this...
  );
}
