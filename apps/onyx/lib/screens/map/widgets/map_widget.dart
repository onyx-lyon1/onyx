import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster_2/flutter_map_marker_cluster.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/map/widgets/popup_widgets/restaurant_pop_up_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    this.batiments = const [],
    this.polylines = const [],
    this.restaurant = const [],
    required this.onTapNavigate,
    this.mapController,
    this.center,
    this.enableFullscreenButton = false,
  });

  final List<BatimentModel> batiments;
  final List<RestaurantModel> restaurant;
  final List<Polyline> polylines;
  final LatLng? center;
  final AnimatedMapController? mapController;
  final void Function(LatLng) onTapNavigate;

  final bool enableFullscreenButton;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  late AnimatedMapController mapController;

  Future<String> getPath() async {
    final cacheDirectory = await getTemporaryDirectory();
    return cacheDirectory.path;
  }

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
          alignment: Alignment.center,
          point: element.position,
          child: Icon(
            Icons.location_on_rounded,
            size: 20.sp,
            color: Colors.red,
            semanticLabel: element.name,
          ),
        ),
      for (var element in widget.restaurant)
        Marker(
          alignment: Alignment.center,
          point: LatLng(element.lat, element.lon),
          child: Icon(
            Icons.restaurant_rounded,
            size: 20.sp,
            color: Colors.green,
            semanticLabel: element.name,
          ),
        ),
    ];

    if (widget.center == null) {
      GeolocationLogic.getCurrentLocation(
              askPermission: false, context: context)
          .then((value) async {
        if (value != null) {
          mapController.centerOnPoint(value, zoom: 16.5);
        }
      });
    }

    if (widget.polylines.isNotEmpty) {
      List<LatLng> points = widget.polylines.expand((e) => e.points).toList();
      if (points.isNotEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          mapController.animatedFitCamera(
            cameraFit: CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(widget.polylines.first.points),
              padding: const EdgeInsets.all(25),
            ),
          );
        });
      }
    }

    Widget button = Align(
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
                    GeolocationLogic.getCurrentLocation(
                            askPermission: true, context: context)
                        .then((value) {
                      setState(() {
                        if ((value != null)) {
                          mapController.centerOnPoint(value, zoom: 15);
                        }
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.surface),
                  ),
                  icon: Icon(
                    Icons.location_searching_rounded,
                    size: 25.sp,
                    color: Theme.of(context).primaryColor,
                  )),
            ),
          Padding(
            padding: EdgeInsets.all(2.h),
            child: IconButton(
                onPressed: () {
                  mapController.centerOnPoint(MapRes.center, zoom: 16.5);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.surface),
                ),
                icon: Icon(
                  Icons.location_city_rounded,
                  size: 25.sp,
                  color: Theme.of(context).primaryColor,
                )),
          ),
        ],
      ),
    );

    Widget map = FutureBuilder<String>(
      future: getPath(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return PopupScope(
          popupController: popupLayerController,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: widget.center ?? MapRes.center,
              initialZoom: 16.5,
              maxZoom: MapRes.maxZoom,
              minZoom: 0,
              onTap: (_, __) => popupLayerController.hideAllPopups(),
            ),
            mapController: mapController.mapController,
            children: [
              TileLayer(
                tileProvider: CachedTileProvider(
                  maxStale: const Duration(days: 30),
                  store: HiveCacheStore(
                    snap.data!,
                    hiveBoxName: 'HiveCacheStore',
                  ),
                ),
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'fr.onyx.lyon1',
              ),
              if (widget.polylines.isNotEmpty &&
                  !widget.polylines.any((element) => element.points.isEmpty))
                PolylineLayer(
                  polylines: widget.polylines,
                ),
              if (!kIsWeb &&
                  !(Platform.isLinux || Platform.isMacOS || Platform.isWindows))
                const CustomCurrentLocationLayerWidget(),
              if (markers.isNotEmpty)
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    maxClusterRadius: 120,
                    rotate: false,
                    size: const Size(40, 40),
                    spiderfyCluster: false,
                    disableClusteringAtZoom: 15,
                    zoomToBoundsOnClick: false,
                    alignment: Alignment.center,
                    maxZoom: 15,
                    padding: const EdgeInsets.all(50),
                    markers: markers,
                    popupOptions: PopupOptions(
                      popupSnap: PopupSnap.markerTop,
                      popupController: popupLayerController,
                      popupBuilder: (context, marker) {
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
                    builder: (context, markers) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Center(
                          child: Text(
                            markers.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );

    return OpenContainer(
      openBuilder: (BuildContext context, void Function() callback) => Stack(
        children: [
          map,
          button,
          if (widget.enableFullscreenButton)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: IconButton(
                    onPressed: () {
                      callback();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.surface),
                    ),
                    icon: Icon(
                      Icons.zoom_in_map_rounded,
                      size: 25.sp,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            ),
        ],
      ),
      closedBuilder: (BuildContext context, void Function() callback) => Stack(
        children: [
          map,
          button,
          if (widget.enableFullscreenButton)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: IconButton(
                    onPressed: () {
                      callback();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.surface),
                    ),
                    icon: Icon(
                      Icons.zoom_out_map_rounded,
                      size: 25.sp,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
