import 'package:latlong2/latlong.dart';

extension LatLngInside on LatLng {
  bool inside(LatLng min, LatLng max) {
    return (latitude >= min.latitude &&
        latitude <= max.latitude &&
        longitude >= min.longitude &&
        longitude <= max.longitude);
  }
}
