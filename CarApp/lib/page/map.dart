import 'dart:async';

import 'package:carapp/globals/AppData.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static const _kGooglePlex = CameraPosition(
    target: LatLng(40, 20),
    zoom: 1,
  );

  @override
  Widget build(BuildContext context) {
    final markers = Provider.of<AppData>(context).markers;

    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        initialCameraPosition: _kGooglePlex,
        markers: markers.toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
