import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:oloid2/core/extensions/extensions_export.dart';
import 'package:oloid2/screens/map/map_export.dart';

class NavigationLogic {
  static Future<List<List<LatLng>>> navigateToBatimentFromLocation(
      BuildContext context, List<BatimentModel> batiments) async {
    LatLng latLng = await GeolocationLogic.getCurrentLocation();
    List<List<LatLng>> paths = [];
    if (latLng.inside(MapRes.minBound, MapRes.maxBound)) {
      for (var coord in batiments) {
        paths.add(
          await OsrmLogic.calculateRoute(
            latLng,
            coord.position,
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text("Vous n'êtes pas sur le campus"),
        ),
      );
    }
    return paths;
  }
}
