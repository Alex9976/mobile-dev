import 'dart:io';

import 'package:carapp/constants/LanguageConstants.dart';
import 'package:carapp/extensions/string_extensions.dart';
import 'package:carapp/services/DataService.dart';
import 'package:carapp/services/FirebaseService.dart';
import 'package:carapp/services/TextService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  State createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  DataService appData = DataService();

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<TextService>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: DataService.primaryColor,
          title: Text(
            LanguageConstants.addCarTitle.t(context),
            style: TextStyle(fontSize: fontProvider.fontSize),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const MyStatefulWidget(),
        ),
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
    final fontProvider = Provider.of<TextService>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            style: TextStyle(
                fontSize: fontProvider.fontSize, color: fontProvider.fontColor),
            decoration: InputDecoration(
              hintText: LanguageConstants.enterCarName.t(context),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return LanguageConstants.enterCarNameError.t(context);
              }
              name = value;
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            style: TextStyle(
                fontSize: fontProvider.fontSize, color: fontProvider.fontColor),
            decoration: InputDecoration(
              hintText: LanguageConstants.enterCarLat.t(context),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return LanguageConstants.enterCarLatError.t(context);
              }
              if (double.tryParse(value) == null) {
                return LanguageConstants.enterCarLatLonNumError.t(context);
              }
              latitude = double.tryParse(value)!;
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            style: TextStyle(
                fontSize: fontProvider.fontSize, color: fontProvider.fontColor),
            decoration: InputDecoration(
              hintText: LanguageConstants.enterCarLon.t(context),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return LanguageConstants.enterCarLonError.t(context);
              }
              if (double.tryParse(value) == null) {
                return LanguageConstants.enterCarLatLonNumError.t(context);
              }
              longitude = double.tryParse(value)!;
              return null;
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: MaterialButton(
                textColor: Colors.white,
                color: DataService.primaryColor,
                onPressed: () => pickImage(),
                child: Text(
                  LanguageConstants.selectImg.t(context),
                  style: TextStyle(
                      fontSize: fontProvider.fontSize, color: Colors.white),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: DataService.primaryColor),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (image == null) {
                      Fluttertoast.showToast(
                        msg: LanguageConstants.enterCarLat.t(context),
                        toastLength: Toast.LENGTH_SHORT,
                        textColor: Colors.black,
                        fontSize: 16,
                        backgroundColor: Colors.grey[200],
                      );
                    } else {
                      FirebaseService.addNewCar(
                          name, latitude, longitude, image as File);
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  LanguageConstants.submit.t(context),
                  style: TextStyle(
                      fontSize: fontProvider.fontSize, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
