import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:requests/requests.dart';

class OsrmDemo {
  // https://routing.openstreetmap.de/routed-foot/route/v1/driving/9.700927734375,50.41551870402678;12.480468749999998,49.59647007089266?overview=false&alternatives=true&steps=true
  static Future<Polyline?> calculateRoute(
      LatLng departure, LatLng arrival) async {
    var url =
        'https://routing.openstreetmap.de/routed-foot/route/v1/driving/${departure.longitude},${departure.latitude};${arrival.longitude},${arrival.latitude}?overview=false&alternatives=false&steps=true';
    var r = await Requests.get(url);
    var json = jsonDecode(r.content());
    List steps = json['routes'][0]['legs'][0]['steps'];
    List<LatLng> points = [];
    for (var step in steps) {
      points.add(LatLng(
          step['maneuver']['location'][1], step['maneuver']['location'][0]));
    }
    return Polyline(
      points: points,
      strokeWidth: 4.0,
      color: Colors.red,
    );
  }
}
