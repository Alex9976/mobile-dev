import 'package:carapp/globals/AppData.dart';
import 'package:carapp/page/addCar.dart';
import 'package:flutter/foundation.dart';
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
      body: RefreshIndicator(
        onRefresh: () async => {},
        child: ListView.builder(
            itemCount: cars.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 150,
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      padding: EdgeInsets.all(2),
                      child: Image.network(cars[index].imagePath),
                    ),
                    Center(child: Text('Entry ${cars[index].name}')),
                    Center(
                        child:
                            Text('Entry ${cars[index].weather.description}')),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCarPage(),
            ),
          );
        },
        tooltip: 'Add car',
        child: const Icon(Icons.add),
      ),
    );
  }
}
