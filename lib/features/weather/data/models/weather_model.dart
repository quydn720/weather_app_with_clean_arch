import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required String city,
    required String country,
    String description = '',
    int dt = 0,
    int sunrise = 0,
    int sunset = 0,
    int temperature = 0,
    int minTemperature = 0,
    int maxTemperature = 0,
    int humidity = 0,
    double windSpeed = 0,
  }) : super(
          city: city,
          country: country,
          description: description,
          dt: dt,
          humidity: humidity,
          maxTemperature: maxTemperature,
          minTemperature: minTemperature,
          sunrise: sunrise,
          sunset: sunset,
          temperature: temperature,
          windSpeed: windSpeed,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      country: json['sys']['country'],
      description: json['weather'][0]['description'],
      temperature: (json['main']['temp'] as num).toInt(),
      minTemperature: (json['main']['temp_min'] as num).toInt(),
      maxTemperature: (json['main']['temp_max'] as num).toInt(),
      humidity: json['main']['humidity'],
      dt: json['dt'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      windSpeed: json['wind']['speed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'description': description,
      'temperature': temperature,
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
      'humidity': humidity,
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
      'windSpeed': windSpeed,
    };
  }
}
