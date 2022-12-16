import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDemoWidget extends StatefulWidget {
  const MapDemoWidget({Key? key}) : super(key: key);

  @override
  State<MapDemoWidget> createState() => _MapDemoWidgetState();
}

class _MapDemoWidgetState extends State<MapDemoWidget> {
  Polyline? route;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(45.77943, 4.85877),
          zoom: 14.0,
          maxZoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "assets/map/{z}/{x}/{y}.png",
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            tileProvider: AssetTileProvider(),
          ),
          PolylineLayer(
            polylines: [
              route ??
                  Polyline(
                    points: [
                      LatLng(45.77943, 4.85877),
                      LatLng(45.78880, 4.88829),
                    ],
                    strokeWidth: 4.0,
                    color: Colors.red,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
