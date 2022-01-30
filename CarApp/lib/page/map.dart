import 'dart:async';

import 'package:carapp/services/DataService.dart';
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

  @override
  Widget build(BuildContext context) {
    final markers = Provider.of<DataService>(context).markers;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 37, left: 0, right: 0, bottom: 0),
        child: GoogleMap(
          initialCameraPosition: DataService.cameraPosition,
          markers: markers.toSet(),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onCameraMove: (CameraPosition position) {
            DataService.cameraPosition = position;
          },
        ),
      ),
    );
  }
}
