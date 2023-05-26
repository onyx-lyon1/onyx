import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/screens/map/domain/logic/tile_provider_logic.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:sizer/sizer.dart';

class MapWidget extends StatefulWidget {
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
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late MapController mapController;

  @override
  void initState() {
    mapController = widget.mapController ?? MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PopupController popupLayerController = PopupController();
    List<Marker> markers = widget.batiments.map((element) {
      return Marker(
        point: element.position,
        builder: (context) => Icon(
          Icons.location_on_rounded,
          size: 15.sp,
          color: Colors.red,
          semanticLabel: element.name,
        ),
      );
    }).toList();
    if (widget.center == null) {
      GeolocationLogic.getCurrentLocation(askPermission: false)
          .then((value) async {
        if (value != null) {
          mapController.move(value, 16.5);
        }
      });
    }
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: widget.center ?? MapRes.center,
            zoom: 16.5,
            maxZoom: MapRes.maxZoom,
            minZoom: 0,
          ),
          mapController: mapController,
          children: [
            TileLayer(tileProvider: HybridTileProvider() //AssetTileProvider(),
                ),
            if (widget.polylines.isNotEmpty)
              PolylineLayer(
                polylines: widget.polylines,
                polylineCulling: true,
              ),
            if (!Platform.isLinux && !Platform.isMacOS && !Platform.isWindows)
              const CustomCurrentLocationLayerWidget(),
            if (widget.batiments.isNotEmpty)
              PopupMarkerLayerWidget(
                options: PopupMarkerLayerOptions(
                  markers: markers,
                  popupController: popupLayerController,
                  popupBuilder: (BuildContext context, Marker marker) {
                    return MapPopupWidget(
                      batiment: widget.batiments.firstWhere(
                          (element) => element.position == marker.point),
                      onTap: widget.onTapNavigate,
                      popupController: popupLayerController,
                    );
                  },
                ),
              ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!Platform.isLinux && !Platform.isMacOS && !Platform.isWindows)
                Padding(
                  padding: EdgeInsets.all(2.h),
                  child: IconButton(
                      onPressed: () {
                        GeolocationLogic.getCurrentLocation(askPermission: true)
                            .then((value) {
                          setState(() {
                            if ((value != null)) {
                              mapController.move(value, 15);
                            }
                          });
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
              Padding(
                padding: EdgeInsets.all(2.h),
                child: IconButton(
                    onPressed: () {
                      mapController.move(MapRes.center, 16.5);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                    icon: Icon(
                      Icons.location_city_rounded,
                      size: 25.sp,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
