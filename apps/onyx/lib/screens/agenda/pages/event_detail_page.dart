import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/search/search_service.dart';
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
  List<RestaurantModel> restaurants = [];
  List<List<LatLng>> routingPaths = [];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> loadBatimentAndRestaurants() async {
    if (widget.event.menuCrous == null) {
      List<BatimentModel> tmpBatiments = await BatimentsLogic.loadBatiments();
      for (var i in tmpBatiments) {
        if (SearchService.isMatch(widget.event.location, i.name)) {
          batiments.add(i);
          break;
        }
      }
    } else {
      List<RestaurantModel> tmpRestaurants = [];
      if (await CacheService.exist<RestaurantListModel>()) {
        tmpRestaurants =
            (await CacheService.get<RestaurantListModel>())!.restaurantList;
      } else {
        tmpRestaurants = await IzlyClient.getRestaurantCrous();
      }
      for (var i in tmpRestaurants) {
        if (SearchService.isMatch(widget.event.location, i.name)) {
          restaurants.add(i);
          break;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
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
                EventDetailText(
                    icon: Icons.access_time_rounded,
                    text:
                        "${widget.event.start.hour.toFixedLengthString(2)}h${widget.event.start.minute.toFixedLengthString(2)} ${widget.event.end.hour.toFixedLengthString(2)}h${widget.event.end.minute.toFixedLengthString(2)}"),
                EventDetailText(
                  icon: Icons.calendar_month_rounded,
                  text:
                      '${widget.event.start.toWeekDayName()} ${widget.event.start.day} ${widget.event.start.toMonthName()}',
                ),
                if (widget.event.teacher.isNotEmpty)
                  EventDetailText(
                      icon: Icons.person_rounded, text: widget.event.teacher),
                if (widget.event.description.isNotEmpty)
                  Text(widget.event.description),
                if (widget.event.menuCrous != null &&
                    widget.event.menuCrous is MenuCrous)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu_rounded,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        MenuWidget(
                          menuCrous: widget.event.menuCrous,
                        ),
                      ],
                    ),
                  ),
                EventDetailText(
                    icon: Icons.location_on_rounded,
                    text: widget.event.location),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40.h,
                      width: 90.w,
                      child: FutureBuilder(
                          future: loadBatimentAndRestaurants(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: StateDisplayingPage(
                                      message: "Chargement des bâtiments"));
                            }
                            return MapWidget(
                              batiments: batiments,
                              restaurant: restaurants,
                              polylines: [
                                for (var i in routingPaths)
                                  Polyline(
                                    points: i,
                                    strokeWidth: 4.0,
                                    color: Colors.red,
                                  )
                              ],
                              center: (batiments.isNotEmpty)
                                  ? batiments.first.position
                                  : (restaurants.isNotEmpty)
                                      ? LatLng(restaurants.first.lat,
                                          restaurants.first.lon)
                                      : null,
                              onTapNavigate: (position) async {
                                routingPaths.addAll(await NavigationLogic
                                    .navigateToBatimentFromLocation(
                                        context,
                                        batiments
                                            .map((e) => e.position)
                                            .toList()));
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
                          routingPaths = [];
                          if (batiments.isNotEmpty) {
                            routingPaths.addAll(await NavigationLogic
                                .navigateToBatimentFromLocation(context,
                                    batiments.map((e) => e.position).toList()));
                          } else {
                            routingPaths.addAll(await NavigationLogic
                                .navigateToBatimentFromLocation(
                                    context,
                                    restaurants
                                        .map((e) => LatLng(e.lat, e.lon))
                                        .toList()));
                          }

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

class EventDetailText extends StatelessWidget {
  const EventDetailText({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          SelectableText(
            text,
            style: Theme.of(context).textTheme.bodyLarge!,
          ),
        ],
      ),
    );
  }
}
