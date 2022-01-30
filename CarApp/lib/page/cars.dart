import 'package:carapp/constants/AppData.dart';
import 'package:carapp/constants/LanguageConstants.dart';
import 'package:carapp/extensions/string_extensions.dart';
import 'package:carapp/page/add_сar.dart';
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
        title: Text(LanguageConstants.carPageTitle.t(context)),
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
                      width: 160,
                      child: Image.network(cars[index].imagePath),
                    ),
                    Container(
                      width: 220,
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
                          Text("${LanguageConstants.latLabel.t(context)}: ${cars[index].location.latitude}"),
                          Text("${LanguageConstants.lonLabel.t(context)}: ${cars[index].location.longitude}"),
                          Visibility(
                            child: Row(
                              children: [
                                Text("${cars[index].weather.temp.toString()} ℃"),
                                const Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, right: 10, top: 0, bottom: 0)),
                                Container(
                                  width: 50,
                                  padding: const EdgeInsets.all(2),
                                  child: Image.network(
                                      "http://openweathermap.org/img/wn/${cars[index].weather.icon}.png"),
                                ),
                              ],
                            ),
                            visible: cars[index].isWeatherLogged,
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
