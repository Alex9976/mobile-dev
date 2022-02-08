import 'package:carapp/services/FirebaseService.dart';
import 'package:carapp/services/WeatherService.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/Car.dart';

class DataService with ChangeNotifier {
  static final DataService _singleton = DataService._internal();
  static List<Car> _cars = <Car>[];
  static const primaryColor = Color(0xfff4793e);
  static int _screenId = 0;

  static CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(40, 20),
    zoom: 1,
  );

  void setScreenId(int value)
  {
    _screenId = value;
    notifyListeners();
  }

  List<Car> get cars => _cars;
  int get screenId => _screenId;
  List<Marker> get markers => getMarkers();

  List<Marker> getMarkers() {
    List<Marker> markers = <Marker>[];
    for (Car car in _cars) {
      LatLng position = LatLng(car.location.latitude, car.location.longitude);
      String title = car.name;
      String snippet =
          '${car.location.latitude}, ${car.location.longitude}, ${car.weather.temp} ℃';
      markers.add(Marker(
          markerId: const MarkerId('origin'),
          infoWindow: InfoWindow(title: title, snippet: snippet),
          position: position));
    }
    return markers;
  }

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

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
