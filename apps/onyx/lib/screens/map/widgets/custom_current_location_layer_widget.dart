import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';

class CustomCurrentLocationLayerWidget extends StatelessWidget {
  const CustomCurrentLocationLayerWidget({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Geolocator.checkPermission(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              (snapshot.data == LocationPermission.always ||
                  snapshot.data == LocationPermission.whileInUse)) {

            return CurrentLocationLayer();
          }
          return Container();
        });
  }
}
