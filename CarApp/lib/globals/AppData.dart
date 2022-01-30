import 'package:carapp/services/FirebaseService.dart';
import 'package:carapp/services/WeatherService.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/Car.dart';

class AppData with ChangeNotifier {
  static final AppData _singleton = AppData._internal();
  static List<Car> _cars = <Car>[];

  List<Car> get cars => _cars;

  List<Marker> get markers => getMarkers();

  List<Marker> getMarkers() {
    List<Marker> markers = <Marker>[];
    for (Car car in _cars) {
      LatLng position = LatLng(car.location.latitude, car.location.longitude);
      String title = car.name;
      String snippet =
          '${car.location.latitude}, ${car.location.longitude}, ${car.weather.temp} ℃';
      markers.add(Marker(
          markerId: MarkerId('origin'),
          infoWindow: InfoWindow(title: title, snippet: snippet),
          position: position));
    }
    return markers;
  }

  factory AppData() {
    return _singleton;
  }

  AppData._internal();

  void updateCarList() async {
    List<Car> cars = await FirebaseService.getCars();
    _cars = cars;
    notifyListeners();
    updateWeather();
  }

  void updateWeather() async {
    for (Car car in _cars) {
      car.weather = await WeatherService.getWeather(car.location);
    }
    notifyListeners();
  }
}
