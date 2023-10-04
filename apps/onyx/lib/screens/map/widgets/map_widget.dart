import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/map/domain/logic/tile_provider_logic.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/map/widgets/popup_widgets/restaurant_pop_up_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(
      {Key? key,
      this.batiments = const [],
      this.polylines = const [],
      this.restaurant = const [],
      required this.onTapNavigate,
      this.mapController,
      this.center})
      : super(key: key);
  final List<BatimentModel> batiments;
  final List<RestaurantModel> restaurant;
  final List<Polyline> polylines;
  final LatLng? center;
  final AnimatedMapController? mapController;
  final void Function(LatLng) onTapNavigate;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  late AnimatedMapController mapController;

  @override
  void initState() {
    mapController = widget.mapController ??
        AnimatedMapController(
          vsync: this,
          curve: Curves.easeInOut,
          duration: Res.animationDuration,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PopupController popupLayerController = PopupController();
    List<Marker> markers = [
      for (var element in widget.batiments)
        Marker(
          point: element.position,
          builder: (context) => Icon(
            Icons.location_on_rounded,
            size: 20.sp,
            color: Colors.red,
            semanticLabel: element.name,
          ),
        ),
      for (var element in widget.restaurant)
        Marker(
          point: LatLng(element.lat, element.lon),
          builder: (context) => Icon(
            Icons.restaurant_rounded,
            size: 20.sp,
            color: Colors.green,
            semanticLabel: element.name,
          ),
        ),
    ];

    if (widget.center == null) {
      GeolocationLogic.getCurrentLocation(askPermission: false)
          .then((value) async {
        if (value != null) {
          mapController.centerOnPoint(value, zoom: 16.5);
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
            onTap: (tapPos, latLng) {
              popupLayerController.hideAllPopups();
            },
          ),
          mapController: mapController.mapController,
          children: [
            TileLayer(tileProvider: HybridTileProvider()),
            if (widget.polylines.isNotEmpty &&
                !widget.polylines.any((element) => element.points.isEmpty))
              PolylineLayer(
                polylines: widget.polylines,
                polylineCulling: true,
              ),
            if (!kIsWeb &&
                !(Platform.isLinux || Platform.isMacOS || Platform.isWindows))
              const CustomCurrentLocationLayerWidget(),
            if (markers.isNotEmpty)
              PopupMarkerLayer(
                  options: PopupMarkerLayerOptions(
                markers: markers,
                popupController: popupLayerController,
                popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) {
                    int index = widget.batiments.indexWhere(
                        (element) => element.position == marker.point);
                    if (index != -1) {
                      return BatimentPopupWidget(
                        element: widget.batiments[index],
                        onTap: widget.onTapNavigate,
                        popupController: popupLayerController,
                      );
                    } else {
                      index = widget.restaurant.indexWhere((element) =>
                          element.lat == marker.point.latitude &&
                          element.lon == marker.point.longitude);
                      return RestaurantPopUpWidget(
                        element: widget.restaurant[index],
                        onTap: widget.onTapNavigate,
                        popupController: popupLayerController,
                      );
                    }
                  },
                ),
              )),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!kIsWeb &&
                  !Platform.isLinux &&
                  !Platform.isMacOS &&
                  !Platform.isWindows)
                Padding(
                  padding: EdgeInsets.all(2.h),
                  child: IconButton(
                      onPressed: () {
                        GeolocationLogic.getCurrentLocation(askPermission: true)
                            .then((value) {
                          setState(() {
                            if ((value != null)) {
                              mapController.centerOnPoint(value, zoom: 15);
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
                      mapController.centerOnPoint(MapRes.center, zoom: 16.5);
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
