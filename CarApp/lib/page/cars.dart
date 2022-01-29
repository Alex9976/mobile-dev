import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  State createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
  final List<int> colorCodes = <int>[900, 800, 700, 600, 500, 400, 300, 200, 100, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Car")),
      body: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 150,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Image.network("https://picsum.photos/250?image=9"),
                  ),
                  Center(child: Text('Entry ${entries[index]}')),
                ],
              ),
            );
          }
      ),
    );
  }
}