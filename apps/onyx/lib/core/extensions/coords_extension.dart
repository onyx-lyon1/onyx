import 'dart:math' as math;

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

extension CoordsExtension on TileCoordinates {
  LatLng toDeg() {
    final n = math.pow(2.0, z);
    final lonDeg = x / n * 360.0 - 180.0;
    final latRad = math.atan(sinh(math.pi * (1 - 2 * y / n)));
    final latDeg = latRad * 180.0 / math.pi;
    return LatLng(latDeg, lonDeg);
  }
}

double sinh(double angle) {
  return (math.exp(angle) - math.exp(-angle)) / 2;
}
