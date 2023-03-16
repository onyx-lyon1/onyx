import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/map/domain/logic/tile_provider_logic.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:sizer/sizer.dart';

class MapWidget extends StatelessWidget {
  const MapWidget(
      {Key? key,
      this.batiments = const [],
      this.polylines = const [],
      required this.onTapNavigate,
      this.mapController,
      this.center})
      : super(key: key);
  final List<BatimentModel> batiments;
  final List<Polyline> polylines;
  final LatLng? center;
  final MapController? mapController;
  final void Function(BatimentModel) onTapNavigate;

  @override
  Widget build(BuildContext context) {
    /// Used to trigger showing/hiding of popups.
    final PopupController popupLayerController = PopupController();
    List<Marker> markers = batiments.map((element) {
      return Marker(
        point: element.position,
        builder: (context) => Icon(
          Icons.location_on_rounded,
          size: 15.sp,
          color: Colors.red,
        ),
      );
    }).toList();
    if (center == null) {
      GeolocationLogic.getCurrentLocation(askPermission: false).then((value) {
        if ((value != null) && value.inside(MapRes.minBound, MapRes.maxBound)) {
          mapController?.move(value, 16.5);
        }
      });
    }
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: center ?? MapRes.center,
            zoom: 16.5,
            maxZoom: MapRes.maxZoom,
            minZoom: 0,
          ),
          mapController: mapController,
          children: [
            TileLayer(tileProvider: HybridTileProvider() //AssetTileProvider(),
                ),
            if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
            if (!Platform.isLinux && !Platform.isMacOS && !Platform.isWindows)
              const CustomCurrentLocationLayerWidget(),
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
        ),
        if (!Platform.isLinux && !Platform.isMacOS && !Platform.isWindows)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 2.h, bottom: 2.h),
              child: IconButton(
                  onPressed: () {
                    GeolocationLogic.getCurrentLocation(askPermission: true)
                        .then((value) {
                      if ((value != null)) {
                        mapController?.move(value, 15);
                      }
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  icon: Icon(
                    Icons.location_searching_rounded,
                    size: 25.sp,
                  )),
            ),
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 2.h, bottom: 2.h),
            child: IconButton(
                onPressed: () {
                  mapController!.move(MapRes.center, 16.5);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                icon: Icon(
                  Icons.location_city_rounded,
                  size: 25.sp,
                )),
          ),
        ),
      ],
    );
  }
}
