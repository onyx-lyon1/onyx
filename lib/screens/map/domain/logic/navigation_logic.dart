import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/screens/map/map_export.dart';

class NavigationLogic {
  static Future<List<List<LatLng>>> navigateToBatimentFromLocation(
      BuildContext context, List<BatimentModel> batiments) async {
    LatLng latLng = (await GeolocationLogic.getCurrentLocation())!;
    List<List<LatLng>> paths = [];
    for (var coord in batiments) {
      paths.add(
        await OsrmLogic.calculateRoute(
          latLng,
          coord.position,
        ),
      );
    }
    return paths;
  }
}
