import 'dart:async';

import 'package:carapp/constants/LanguageConstants.dart';
import 'package:carapp/extensions/string_extensions.dart';
import 'package:carapp/services/DataService.dart';
import 'package:carapp/services/TextService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  final items = <Marker>[];
  final textController = TextEditingController();
  String query = "";

  void _filterSearchResults(List<Marker> markers) {
    if (query.isNotEmpty && query.length >= 3) {
      items.clear();
      setState(() {
        for (var marker in markers) {
          if (marker.infoWindow.title
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase())) {
            items.add(marker);
          }
        }
      });
    } else {
      setState(() {
        items.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<TextService>(context);
    final markers = Provider.of<DataService>(context).markers;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.only(top: 37, left: 0, right: 0, bottom: 0),
            child: GoogleMap(
              initialCameraPosition: DataService.cameraPosition,
              markers: markers.toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
              },
              onCameraIdle: () => FocusScope.of(context).unfocus(),
              onCameraMove: (CameraPosition position) {
                DataService.cameraPosition = position;
              },
            ),
          ),
          Positioned(
            top: 50,
            right: 15,
            left: 15,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      const Icon(Icons.search),
                      Expanded(
                        child: TextField(
                          controller: textController,
                          onChanged: (value) {
                            query = value;
                            _filterSearchResults(markers);
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              hintText:
                                  LanguageConstants.searchLabel.t(context)),
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.grey,
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            items.clear();
                            textController.clear();
                            FocusScope.of(context).unfocus();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: items.length * 50,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => {
                            mapController
                                ?.animateCamera(CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: items[index].position,
                                    zoom: 11,
                                  ),
                                )),
                            setState(() {
                              items.clear();
                              textController.clear();
                            })
                          },
                          child: ListTile(
                            title: Text(
                              items[index].infoWindow.title.toString(),
                              style: TextStyle(
                                  fontSize: fontProvider.fontSize,
                                  color: fontProvider.fontColor),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
