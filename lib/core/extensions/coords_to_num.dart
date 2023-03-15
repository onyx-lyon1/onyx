import 'dart:math' as math;

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

extension CoordsToNum on Coords<num> {
  LatLng toDeg() {
    final n = math.pow(2.0, z);
    final lon_deg = x / n * 360.0 - 180.0;
    final lat_rad = math.atan(sinh(math.pi * (1 - 2 * y / n)));
    final lat_deg = lat_rad * 180.0 / math.pi;
    return LatLng(lat_deg, lon_deg);
  }
}

double sinh(double angle) {
  return (math.exp(angle) - math.exp(-angle)) / 2;
}
