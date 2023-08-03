import 'dart:math';

import 'package:latlong2/latlong.dart';

extension LatLngExt on LatLng {
  bool inside(LatLng min, LatLng max) {
    return (latitude >= min.latitude &&
        latitude <= max.latitude &&
        longitude >= min.longitude &&
        longitude <= max.longitude);
  }

  double distance(LatLng b) {
    const double radius = 6371000; // Rayon de la Terre en mètres
// Convertir les coordonnées en radians
    double lat1Rad = latitudeInRad;
    double lon1Rad = longitudeInRad;
    double lat2Rad = b.latitudeInRad;
    double lon2Rad = b.longitudeInRad;

// Calculer la différence de latitudes et de longitudes
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

// Appliquer la formule de la distance entre deux points sur une sphère
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radius * c;

    return distance;
  }
}
