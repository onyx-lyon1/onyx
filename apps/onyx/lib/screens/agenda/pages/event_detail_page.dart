import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;

  const EventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<BatimentModel> batiments = [];
  List<List<LatLng>> batimentsPaths = [];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> loadBatiment() async {
    batiments = await BatimentsLogic.findBatiment(widget.event.location);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
                  "Détail de l'événement",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20.sp,
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
                  widget.event.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      SelectableText(
                        "${widget.event.start.hour.toFixedLengthString(2)}h${widget.event.start.minute.toFixedLengthString(2)} ${widget.event.end.hour.toFixedLengthString(2)}h${widget.event.end.minute.toFixedLengthString(2)}",
                        style: Theme.of(context).textTheme.bodyLarge!,
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
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      SelectableText(
                        '${widget.event.start.toWeekDayName()} ${widget.event.start.day} ${widget.event.start.toMonthName()}',
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        SelectableText(
                          widget.event.location,
                          style: Theme.of(context).textTheme.bodyLarge!,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40.h,
                      width: 90.w,
                      child: FutureBuilder(
                          future: loadBatiment(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: StateDisplayingPage(
                                      message: "Chargement des bâtiments"));
                            }
                            return MapWidget(
                              batiments: batiments,
                              polylines: [
                                for (var i in batimentsPaths)
                                  Polyline(
                                    points: i,
                                    strokeWidth: 4.0,
                                    color: Colors.red,
                                  )
                              ],
                              center: (batiments.isNotEmpty)
                                  ? batiments.first.position
                                  : null,
                              onTapNavigate: (position) async {
                                batimentsPaths.addAll(await NavigationLogic
                                    .navigateToBatimentFromLocation(
                                        context, batiments));
                                setState(() {});
                              },
                            );
                          }),
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
                          batimentsPaths.addAll(await NavigationLogic
                              .navigateToBatimentFromLocation(
                                  context, batiments));
                          setState(() {});
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Center(
                          child: Text(
                            "Itinéraire",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
