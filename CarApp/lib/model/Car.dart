import 'package:carapp/model/Location.dart';
import 'package:carapp/model/Weather.dart';

class Car {
  final String name;
  final String imagePath;
  final Location location;
  Weather weather;

  Car(
      {required this.name,
      required this.imagePath,
      required this.location,
      required this.weather});
}
