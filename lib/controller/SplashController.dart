import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_test/repo/location_repo.dart';
import 'package:google_maps_test/screens/MapsScreen.dart';
import 'package:google_maps_test/screens/Splash.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashController extends ControllerMVC {
  bool retryState = false;
  bool loading = false;
  startTimer() async {
    Timer timer = Timer(Duration(seconds: 2), () async {
      retryState = true;
      setState(() {});
      getLocation();
    });
  }

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("Please allow location service"),
      //   duration: const Duration(seconds: 3),
      // ));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please allow location permission"),
          duration: const Duration(seconds: 3),
        ));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Location permissions are permanently denied, we cannot request permissions."),
        duration: const Duration(seconds: 3),
      ));
    }
    loading = true;
    setState(() {});
    Position currentPosition;
    try {
      currentPosition = await Geolocator.getCurrentPosition();
      loading = false;
      currentLocation.value = currentPosition;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MapsScreen()));
    } catch (e) {
      loading = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Please allow location access and turn on location to proceed"),
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
