import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:oloid2/core/extensions/int_to_sized_string.dart';
import 'package:oloid2/core/extensions/month_to_string.dart';
import 'package:oloid2/core/extensions/weekday_to_string.dart';
import 'package:oloid2/demo/map_demo.dart';
import 'package:oloid2/demo/osrm_demo.dart';
import 'package:oloid2/screens/agenda/agenda_export.dart';
import 'package:sizer/sizer.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;

  const EventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<dynamic> batiments = [];
  List<Marker> batimentsMarkers = [];
  List<Polyline> batimentsPolylines = [];

  @override
  void initState() {
    rootBundle.loadString("assets/batiment_lyon1.json").then((value) {
      setState(() {
        batiments = jsonDecode(value);
        batimentsMarkers = batiments
            .where((element) =>
                element["name"]
                    .toLowerCase()
                    .contains(widget.event.location.toLowerCase()) ||
                widget.event.location
                    .toLowerCase()
                    .contains(element["name"].toLowerCase()))
            .map((element) {
          return Marker(
            point: LatLng(
              double.parse(element["coordinates"][1].toString()),
              double.parse(element["coordinates"][0].toString()),
            ),
            builder: (ctx) => Icon(
              Icons.location_on,
              size: 15.sp,
              color: Colors.red,
            ),
          );
        }).toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).cardColor,
          width: 100.w,
          height: 7.h,
          child: Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_upward_rounded)),
              Text(
                "Détail de l'évènement",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13.sp,
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                widget.event.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    SelectableText(
                      "${widget.event.start.hour.toFixedLengthString(2)}h${widget.event.start.minute.toFixedLengthString(2)}",
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                    SelectableText(
                      "${widget.event.end.hour.toFixedLengthString(2)}h${widget.event.end.minute.toFixedLengthString(2)}",
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    SelectableText(
                      '${widget.event.start.toWeekDayName()} ${widget.event.start.day} ${widget.event.start.toMonthName()}',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    SelectableText(
                      widget.event.location,
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 40.h,
                    width: 90.w,
                    child: MapDemoWidget(
                      markers: batimentsMarkers,
                      polylines: batimentsPolylines,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: SizedBox(
                  height: 8.h,
                  child: Material(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () async {
                        LocationPermission permission;
                        bool serviceEnabled =
                            await Geolocator.isLocationServiceEnabled();
                        if (!serviceEnabled) {
                          // Location services are not enabled don't continue
                          // accessing the position and request users of the
                          // App to enable the location services.
                          return Future.error(
                              'Location services are disabled.');
                        }

                        permission = await Geolocator.checkPermission();
                        if (permission == LocationPermission.denied) {
                          permission = await Geolocator.requestPermission();
                          if (permission == LocationPermission.denied) {
                            // Permissions are denied, next time you could try
                            // requesting permissions again (this is also where
                            // Android's shouldShowRequestPermissionRationale
                            // returned true. According to Android guidelines
                            // your App should show an explanatory UI now.
                            return Future.error(
                                'Location permissions are denied');
                          }
                        }

                        if (permission == LocationPermission.deniedForever) {
                          // Permissions are denied forever, handle appropriately.
                          return Future.error(
                              'Location permissions are permanently denied, we cannot request permissions.');
                        }

                        // When we reach here, permissions are granted and we can
                        // continue accessing the position of the device.
                        Position userPos =
                            await Geolocator.getCurrentPosition();
                        for (var coord in batimentsMarkers) {
                          batimentsPolylines.add(
                            await OsrmDemo.calculateRoute(
                              LatLng(userPos.latitude, userPos.longitude),
                              coord.point,
                            ),
                          );
                        }
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Text(
                          "Itinéraire",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 15.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
