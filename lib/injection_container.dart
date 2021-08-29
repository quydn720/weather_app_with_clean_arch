import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_w_clean_architeture/core/location/location_info.dart';
import 'package:weather_app_w_clean_architeture/core/network/network_info.dart';
import 'package:weather_app_w_clean_architeture/core/validate/validator.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_w_clean_architeture/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_city_name.dart';
import 'package:weather_app_w_clean_architeture/features/weather/domain/usecases/get_weather_by_location.dart';
import 'package:weather_app_w_clean_architeture/features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => WeatherBloc(
      getWeatherByCityName: sl(),
      getWeatherByLocation: sl(),
      validator: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetWeatherByCityName(sl()));

  sl.registerLazySingleton(() => GetWeatherByLocation(sl()));
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      locationInfo: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(sl()));

  sl.registerFactory<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerFactory<LocationInfo>(() => LocationInfoImpl());
  sl.registerLazySingleton(() => InputValidator());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  //sl.registerLazySingleton(() => Geolocator());
}
