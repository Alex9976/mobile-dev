import 'package:carapp/globals/AppData.dart';
import 'package:carapp/page/addCar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarPage extends StatefulWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  State createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<AppData>(context).cars;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Car list"),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCarPage(),
                    ),
                  );
                },
                child: Icon(Icons.add),
              )),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => {AppData().updateCarList()},
        child: ListView.builder(
            itemCount: cars.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 150,
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Container(
                      width: 200,
                      child: Image.network(cars[index].imagePath),
                    ),
                    Container(
                      width: 180,
                      padding: const EdgeInsets.only(
                          left: 10, right: 0, top: 0, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cars[index].name,
                              overflow: TextOverflow.ellipsis),
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 0, right: 0, top: 10, bottom: 0)),
                          Text("Latitude: ${cars[index].location.latitude}"),
                          Text("Longitude: ${cars[index].location.longitude}"),
                          Row(
                            children: [
                              Text("${cars[index].weather.temp.toString()} ℃"),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 10, top: 0, bottom: 0)),
                              Center(
                                  child: Text(cars[index].weather.description)),
                              Container(
                                width: 50,
                                padding: const EdgeInsets.all(2),
                                child: Image.network(
                                    "http://openweathermap.org/img/wn/${cars[index].weather.icon}.png"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
