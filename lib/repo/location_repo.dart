import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

ValueNotifier<Position> currentLocation =
    new ValueNotifier(Position(latitude: 0.0, longitude: 0.0, altitude: 0.0));
