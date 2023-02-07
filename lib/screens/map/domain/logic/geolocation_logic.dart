import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/map/map_export.dart';

class GeolocationLogic {
  static Future<LatLng> getCurrentLocation() async {
    if (Res.mock) {
      return mockLatLng;
    }
    if (kIsWeb || Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      return mockLatLng;
    }
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position userPos = await Geolocator.getCurrentPosition();
    return LatLng(userPos.latitude, userPos.longitude);
  }

  static final LatLng mockLatLng = MapRes.center;
}
