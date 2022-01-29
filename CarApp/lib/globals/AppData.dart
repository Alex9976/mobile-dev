import '../model/Car.dart';

class AppData {
  static final AppData _singleton = AppData._internal();
  final List<Car> cars = <Car>[];

  factory AppData() {
    return _singleton;
  }

  AppData._internal();
}