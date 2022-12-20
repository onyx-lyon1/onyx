import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDemoWidget extends StatefulWidget {
  const MapDemoWidget(
      {Key? key, this.markers = const [], this.polylines = const []})
      : super(key: key);
  final List<Marker> markers;
  final List<Polyline> polylines;

  @override
  State<MapDemoWidget> createState() => _MapDemoWidgetState();
}

class _MapDemoWidgetState extends State<MapDemoWidget> {
  Polyline? route;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(45.782475, 4.872051),
        // center: LatLng(45.783761, 4.875095),
        zoom: 14.0,
        maxZoom: 18.0,
        minZoom: 14.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "assets/map/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          tileProvider: AssetTileProvider(),
        ),
        if (widget.markers.isNotEmpty) MarkerLayer(markers: widget.markers),
        if (widget.polylines.isNotEmpty)
          PolylineLayer(polylines: widget.polylines),
      ],
    );
  }
}
