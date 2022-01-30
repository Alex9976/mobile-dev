import 'dart:convert';

import 'package:carapp/model/Location.dart';
import 'package:carapp/model/Weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static final WeatherService _singleton = WeatherService._internal();

  factory WeatherService() {
    return _singleton;
  }

  WeatherService._internal();

  static Future<Weather> getWeather(Location location) async {
    Weather weather = Weather.empty();
    String latitude = location.latitude.toString();
    String longitude = location.longitude.toString();
    String apiKey = '94dc1074110348afc7eaa29770732d95';
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,daily,hourly,alerts&units=metric&appid=$apiKey");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {}
    return weather;
  }
}
