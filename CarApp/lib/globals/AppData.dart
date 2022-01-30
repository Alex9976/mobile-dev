import 'package:carapp/model/Weather.dart';
import 'package:carapp/services/FirebaseService.dart';
import 'package:carapp/services/WeatherService.dart';
import 'package:flutter/cupertino.dart';

import '../model/Car.dart';

class AppData with ChangeNotifier {
  static final AppData _singleton = AppData._internal();
  static List<Car> _cars = <Car>[];

  List<Car> get cars => _cars;

  factory AppData() {
    return _singleton;
  }

  AppData._internal();

  void updateCarList() async {
    List<Car> cars = await FirebaseService.getCars();
    _cars = cars;
    updateWeather();
  }

  void updateWeather() async {
    for (Car car in _cars) {
      car.weather = await WeatherService.getWeather(car.location);
    }
    notifyListeners();
  }
}
