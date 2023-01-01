import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:sizer/sizer.dart';

class MapWidget extends StatelessWidget {
  const MapWidget(
      {Key? key,
      this.batiments = const [],
      this.polylines = const [],
      required this.onTapNavigate,
      this.center})
      : super(key: key);
  final List<BatimentModel> batiments;
  final List<Polyline> polylines;
  final LatLng? center;
  final void Function(BatimentModel) onTapNavigate;

  @override
  Widget build(BuildContext context) {
    /// Used to trigger showing/hiding of popups.
    final PopupController popupLayerController = PopupController();
    List<Marker> markers = batiments.map((element) {
      return Marker(
        point: element.position,
        builder: (context) => Icon(
          Icons.location_on,
          size: 15.sp,
          color: Colors.red,
        ),
      );
    }).toList();
    return FlutterMap(
      options: MapOptions(
        center: center ?? MapRes.center,
        zoom: 16.5,
        maxZoom: MapRes.maxZoom,
        minZoom: MapRes.minZoom,
        maxBounds: LatLngBounds(
          MapRes.minBound,
          MapRes.maxBound,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: "assets/map/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          tileProvider: AssetTileProvider(),
        ),
        if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
        if (!Platform.isLinux && !Platform.isMacOS && !Platform.isWindows)
          CurrentLocationLayer(),
        if (batiments.isNotEmpty)
          PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              markers: markers,
              popupController: popupLayerController,
              popupBuilder: (BuildContext context, Marker marker) {
                return MapPopupWidget(
                  batiment: batiments.firstWhere(
                      (element) => element.position == marker.point),
                  onTap: onTapNavigate,
                  popupController: popupLayerController,
                );
              },
            ),
          ),
      ],
    );
  }
}
