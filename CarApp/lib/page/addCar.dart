import 'dart:io';

import 'package:carapp/globals/AppData.dart';
import 'package:carapp/services/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  State createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  AppData appData = AppData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Car")),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? image;
  String name = "";
  double latitude = 0;
  double longitude = 0;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter car name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              name = value;
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter car latitude',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter latitude';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter number';
              }
              latitude = double.tryParse(value)!;
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter car longitude',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter longitude';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter number';
              }
              longitude = double.tryParse(value)!;
              return null;
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MaterialButton(
                textColor: Colors.white,
                color: Colors.pink,
                onPressed: () => pickImage(),
                child: Text("Select Image"),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (image == null) {
                      Fluttertoast.showToast(
                        msg: "Select image",
                        toastLength: Toast.LENGTH_SHORT,
                        textColor: Colors.black,
                        fontSize: 16,
                        backgroundColor: Colors.grey[200],
                      );
                    } else {
                      FirebaseService.addNewCar(name, latitude, longitude, image as File);
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
