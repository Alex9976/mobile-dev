import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carapp/model/Car.dart';
import 'package:carapp/model/Location.dart';
import 'package:carapp/model/Weather.dart';
import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  State createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  List<Car> entries = <Car>[];

  void setList() async {
    Location loc = Location(
        latitude: 33.44,
        longitude: -94.04
    );

    Weather weather = await getWeather(loc);

    for (int i = 0; i < 10; i++)
    {
      entries.add(Car(name: "Tesla", imagePath: "https://picsum.photos/250?image=9", location: loc, weather: weather));
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

  @override
  Widget build(BuildContext context) {

    Location loc = Location(
        latitude: 33.44,
        longitude: -94.04
    );

    Weather weather = Weather(temp: 7.36, description: "Rain", icon: "id10");

    for (int i = 0; i < 10; i++)
    {
      entries.add(Car(name: "Tesla", imagePath: "https://picsum.photos/250?image=9", location: loc, weather: weather));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Car")),
      body: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 150,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Image.network("https://picsum.photos/250?image=9"),
                  ),
                  Center(child: Text('Entry ${entries[index].name}')),
                  Center(child: Text('Entry ${entries[index].weather.description}')),
                ],
              ),
            );
          }
      ),
    );
  }
}