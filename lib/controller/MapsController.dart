import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_test/repo/location_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MapController extends ControllerMVC {
  Completer<GoogleMapController> mapController = Completer();

  CameraPosition initialPosition = CameraPosition(
    target:
        LatLng(currentLocation.value.latitude, currentLocation.value.longitude),
    zoom: 18.4746,
  );

  CameraPosition currentPosition = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(
          currentLocation.value.latitude, currentLocation.value.longitude),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> animateToCurrent() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
  }
}
