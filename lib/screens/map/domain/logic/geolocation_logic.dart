import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeolocationLogic{
  static Future<LatLng> getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled =
    await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(
          'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position userPos =
    await Geolocator.getCurrentPosition();
    return LatLng(userPos.latitude, userPos.longitude);
  }
}