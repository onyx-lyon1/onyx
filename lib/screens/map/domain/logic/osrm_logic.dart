import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:requests/requests.dart';

class OsrmLogic {
  static Future<List<LatLng>> calculateRoute(
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
    return points;
  }
}
