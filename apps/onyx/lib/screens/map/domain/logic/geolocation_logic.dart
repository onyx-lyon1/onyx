import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/map/map_export.dart';

class GeolocationLogic {
  static Future<LatLng?> getCurrentLocation(
      {bool askPermission = true, required BuildContext context}) async {
    if (Res.mock) {
      return mockLatLng;
    }
    if (kIsWeb || Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      return mockLatLng;
    }
    bool permission = context.read<MapCubit>().state.geolocationAutorisation;
    if (!permission) {
      if (askPermission) {
        permission =
            await context.read<MapCubit>().askGeolocationAutorisation();
      }
    }
    if (!permission) {
      return null;
    }

    Position userPos = await Geolocator.getCurrentPosition();
    return LatLng(userPos.latitude, userPos.longitude);
  }

  static final LatLng mockLatLng = MapRes.center;
}
