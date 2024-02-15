import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/search/search_service.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event, required this.locale});

  final Locale locale;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<BatimentModel> batiments = [];
  RestaurantModel? restaurant;
  List<List<LatLng>> routingPaths = [];

  @override
  void initState() {
    loadBatimentAndRestaurants(widget.locale);
    super.initState();
  }

  Future loadBatimentAndRestaurants(Locale locale) async {
    String search = widget.event.location;
    search = search.toLowerCase().replaceAll("amphi", "");
    if (widget.event.menuCrous == null) {
      List<BatimentModel> tmpBatiments =
          await BatimentsLogic.loadBatiments(locale);
      for (var i in tmpBatiments) {
        if (await SearchService.isMatch(search, i.name, locale)) {
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
      restaurant = tmpRestaurants
          .firstWhere((element) => element.name == widget.event.location);
    }
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
                    icon: const Icon(Icons.arrow_back_rounded)),
                Text(
                  AppLocalizations.of(context).eventDetails,
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
                      "${DateFormat.jm(AppLocalizations.of(context).localeName).format(widget.event.start)} ${DateFormat.jm(AppLocalizations.of(context).localeName).format(widget.event.end)}",
                ),
                EventDetailText(
                  icon: Icons.calendar_month_rounded,
                  text: DateFormat(
                          'yMMMMEEEEd', AppLocalizations.of(context).localeName)
                      .format(widget.event.start),
                ),
                if (widget.event.teacher.isNotEmpty)
                  EventDetailText(
                      icon: Icons.person_rounded, text: widget.event.teacher),
                // if (widget.event.description.isNotEmpty)
                //   Text(widget.event.description),
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
                if (widget.event.description.isNotEmpty)
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
                      child: (batiments.isNotEmpty || restaurant != null)
                          ? MapWidget(
                              batiments: batiments,
                              restaurant: [if (restaurant != null) restaurant!],
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
                                  : (restaurant != null)
                                      ? LatLng(restaurant!.lat, restaurant!.lon)
                                      : null,
                              onTapNavigate: (position) async {
                                // ignore: use_build_context_synchronously
                                List<LatLng> dest;
                                if (batiments.isNotEmpty) {
                                  dest =
                                      batiments.map((e) => e.position).toList();
                                } else {
                                  dest = [
                                    LatLng(restaurant!.lat, restaurant!.lon)
                                  ];
                                }
                                // ignore: use_build_context_synchronously
                                if (!NavigationLogic.calculating) {
                                  NavigationLogic.calculating = true;

                                  routingPaths = (await NavigationLogic
                                      .navigateToBatimentFromLocation(
                                          context, dest));
                                  setState(() {});
                                  NavigationLogic.calculating = false;
                                }
                              },
                            )
                          : Center(
                              child: StateDisplayingPage(
                                  message: AppLocalizations.of(context)
                                      .loadingBuildings),
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
                          List<LatLng> dest;
                          if (batiments.isNotEmpty) {
                            dest = batiments.map((e) => e.position).toList();
                          } else {
                            dest = [LatLng(restaurant!.lat, restaurant!.lon)];
                          }
                          // ignore: use_build_context_synchronously
                          if (!NavigationLogic.calculating) {
                            NavigationLogic.calculating = true;

                            routingPaths = (await NavigationLogic
                                .navigateToBatimentFromLocation(context, dest));
                            setState(() {});
                            NavigationLogic.calculating = false;
                          }
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).route,
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
      child: SizedBox(
        width: 90.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
