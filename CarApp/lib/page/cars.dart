import 'package:carapp/globals/AppData.dart';
import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  State createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  AppData appData = AppData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Car")),
      body: ListView.builder(
          itemCount: appData.cars.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 150,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Image.network("https://picsum.photos/250?image=9"),
                  ),
                  Center(child: Text('Entry ${appData.cars[index].name}')),
                  Center(child: Text('Entry ${appData.cars[index].weather.description}')),
                ],
              ),
            );
          }
      ),
    );
  }
}