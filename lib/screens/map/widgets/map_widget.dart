import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:oloid2/screens/map/map_export.dart';
import 'package:sizer/sizer.dart';

class MapWidget extends StatelessWidget {
  const MapWidget(
      {Key? key,
      this.batiments = const [],
      this.polylines = const [],
      this.center})
      : super(key: key);
  final List<BatimentModel> batiments;
  final List<Polyline> polylines;
  final LatLng? center;

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
        zoom: 15.5,
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
        if (batiments.isNotEmpty)
          PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              markers: markers,
              popupController: popupLayerController,
              popupBuilder: (BuildContext context, Marker marker) {
                print("builder");
                return MapPopupWidget(
                    batiment: batiments.firstWhere(
                        (element) => element.position == marker.point));
              },
            ),
          ),
        CurrentLocationLayer(),
      ],
    );
  }
}
