import 'dart:convert';

import 'package:carapp/globals/AppData.dart';
import 'package:carapp/model/Car.dart';
import 'package:carapp/model/Location.dart';
import 'package:carapp/model/Weather.dart';
import 'package:http/http.dart' as http;

void setList() async {
  AppData appData = AppData();

  Location loc = Location(
      latitude: 33.44,
      longitude: -94.04
  );

  Weather weather = Weather(temp: 0, description: "", icon: "");//await getWeather(loc);

  for (int i = 0; i < 10; i++)
  {

    appData.cars.add(Car(name: "Tesla", imagePath: "https://picsum.photos/250?image=9", location: loc, weather: weather));
  }
}

Future<Weather> getWeather(Location location) async {
  Weather weather = Weather(temp: 0, description: "", icon: "");
  String latitude = location.latitude.toString();
  String longitude = location.longitude.toString();
  String apiKey = '94dc1074110348afc7eaa29770732d95';
  var url = Uri.parse("https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,daily,hourly,alerts&units=metric&appid=$apiKey");

  final response = await http.get(url);
  if (response.statusCode == 200)
  {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {

  }
  return weather;
}