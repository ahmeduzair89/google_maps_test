import 'package:flutter/material.dart';
import 'package:google_maps_test/controller/SplashController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

SplashController _con;

class _SplashScreenState extends StateMVC<SplashScreen> {
  _SplashScreenState() : super(SplashController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _con.retryState
            ? _con.loading
                ? CircularProgressIndicator()
                : MaterialButton(
                    child: Text("Allow location access"),
                    onPressed: () {
                      _con.getLocation();
                    },
                  )
            : Text("App Logo Here"),
      ),
    );
  }
}
