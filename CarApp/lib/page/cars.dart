import 'package:carapp/constants/LanguageConstants.dart';
import 'package:carapp/extensions/string_extensions.dart';
import 'package:carapp/model/Car.dart';
import 'package:carapp/page/add_сar.dart';
import 'package:carapp/services/DataService.dart';
import 'package:carapp/services/TextService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarPage extends StatefulWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  State createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  TextEditingController editingController = TextEditingController();
  final items = <Car>[];
  String query = "";

  void filterSearchResults(List<Car> cars) {
    if (query.isNotEmpty && query.length >= 3) {
      items.clear();
      setState(() {
        for (var car in cars) {
          if (car.name.toLowerCase().contains(query.toLowerCase())) {
            items.add(car);
          }
        }
      });
    } else {
      setState(() {
        items.clear();
        items.addAll(cars);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<DataService>(context).cars;
    final fontProvider = Provider.of<TextService>(context);
    filterSearchResults(cars);

    @override
    void initState() {
      items.addAll(cars);
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DataService.primaryColor,
        title: Text(
          LanguageConstants.carPageTitle.t(context),
          style: TextStyle(fontSize: fontProvider.fontSize),
        ),
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
                child: const Icon(Icons.add),
              )),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async => {DataService().updateCarList()},
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 8, right: 8, bottom: 5),
                child: TextField(
                  onChanged: (value) {
                    query = value;
                    filterSearchResults(cars);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      hintText: LanguageConstants.searchLabel.t(context),
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => {
                            DataService().setScreenId(1)


                        },
                        child: SizedBox(
                          height: 140,
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                SizedBox(
                                  width: 160,
                                  child: Image.network(items[index].imagePath),
                                ),
                                const Spacer(),
                                const Padding(
                                    padding: EdgeInsets.only(left: 5)),
                                Container(
                                  width: 220,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        items[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: fontProvider.fontSize,
                                            color: fontProvider.fontColor),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      Text(
                                        "${LanguageConstants.latLabel.t(context)}: ${items[index].location.latitude}",
                                        style: TextStyle(
                                            fontSize: fontProvider.fontSize,
                                            color: fontProvider.fontColor),
                                      ),
                                      Text(
                                        "${LanguageConstants.lonLabel.t(context)}: ${items[index].location.longitude}",
                                        style: TextStyle(
                                            fontSize: fontProvider.fontSize,
                                            color: fontProvider.fontColor),
                                      ),
                                      Visibility(
                                        child: Row(
                                          children: [
                                            Text(
                                              "${items[index].weather.temp.toString()} ℃",
                                              style: TextStyle(
                                                  fontSize:
                                                      fontProvider.fontSize,
                                                  color:
                                                      fontProvider.fontColor),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0,
                                                    right: 10,
                                                    top: 0,
                                                    bottom: 0)),
                                            Container(
                                              width: 50,
                                              padding: const EdgeInsets.all(2),
                                              child: Image.network(
                                                  "http://openweathermap.org/img/wn/${items[index].weather.icon}.png"),
                                            ),
                                          ],
                                        ),
                                        visible: items[index].isWeatherLogged,
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
