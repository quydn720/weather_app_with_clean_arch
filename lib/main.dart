import 'package:flutter/material.dart';
import 'package:weather_app_w_clean_architeture/features/weather/presentation/pages/weather_page.dart';
import 'package:weather_app_w_clean_architeture/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}
