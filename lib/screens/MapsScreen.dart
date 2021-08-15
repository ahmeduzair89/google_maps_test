import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_test/controller/MapsController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

MapController _con;

class _MapsScreenState extends StateMVC<MapsScreen> {
  _MapsScreenState() : super(MapController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _con.initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _con.mapController.complete(controller);
        },
      ),
    );
  }
}
