import 'dart:io';

import 'package:carapp/constants/AppData.dart';
import 'package:carapp/model/Car.dart';
import 'package:carapp/model/Location.dart';
import 'package:carapp/model/Weather.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();

  factory FirebaseService() {
    return _singleton;
  }

  static final List<Car> _cars = <Car>[];

  FirebaseService._internal();

  static void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    AppData().updateCarList();
  }

  static void addNewCar(
      String name, double latitude, double longitude, File image) async {
    String imagePath = await uploadImage(image);
    FirebaseFirestore.instance.collection('Cars').add({
      'name': name,
      'imagePath': imagePath,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    });
  }

  static Future<String> uploadImage(File image) async {
    String fileName = basename(image.path);
    String destination = 'images/$fileName';

    var task = uploadFile(destination, image);

    if (task == null) return "";

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future<List<Car>> getCars() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("Cars").get();
    _cars.clear();
    for (var car in snapshot.docs) {
      dynamic carData = car.data();
      String name = carData['name'];
      String imagePath = carData['imagePath'];
      String latitudeStr = carData['latitude'];
      double latitude = double.tryParse(latitudeStr) ?? 0;
      String longitudeStr = carData['longitude'];
      double longitude = double.tryParse(longitudeStr) ?? 0;

      Location location = Location(latitude: latitude, longitude: longitude);
      Weather weather = Weather.empty();

      _cars.add(Car(
          name: name,
          imagePath: imagePath,
          location: location,
          weather: weather));
    }
    return _cars;
  }
}
