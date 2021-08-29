import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_w_clean_architeture/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_w_clean_architeture/injection_container.dart';
import 'package:weather_app_w_clean_architeture/utils/weather_string.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: BlocProvider(
        create: (_) => sl<WeatherBloc>(),
        child: Container(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is Empty) {
                return Center(
                  child: Column(
                    children: [
                      Text('Empty'),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(GetWeatherByCityNameEvent('ho chi minh'));
                        },
                        child: Text('Load weather'),
                      ),
                    ],
                  ),
                );
              } else if (state is Loading) {
                return Center(child: Text('Loading'));
              } else if (state is Loaded) {
                WeatherString w = WeatherString.fromModel(state.weather);
                return Center(
                  child: Column(
                    children: [
                      Text(w.country),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(GetWeatherByCityNameEvent('h minh'));
                        },
                        child: Text('Load weather'),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  color: Colors.red,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// Column(
//                   children: [
//                     Placeholder(
//                       fallbackHeight: MediaQuery.of(context).size.height * 0.6,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Weather now'),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text('Temp ${state.weather.temperature}'),
//                               Text('Wind ${state.weather.windSpeed}'),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text('Rain'),
//                               Text('Humid'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );