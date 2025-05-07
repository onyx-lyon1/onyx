import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_marker_cluster_2/flutter_map_marker_cluster.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:onyx/l10n/app_localizations.dart';

class RestaurantPopUpWidget extends StatelessWidget {
  const RestaurantPopUpWidget(
      {required this.element,
      required this.onTap,
      required this.popupController,
      super.key});

  final RestaurantModel element;
  final void Function(LatLng) onTap;
  final PopupController popupController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      constraints: BoxConstraints(
        maxWidth: 60.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: element.imageUrl,
            width: 60.w,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Text(element.name,
                      style: Theme.of(context).textTheme.bodyLarge)),
              IconButton(
                onPressed: () {
                  onTap(LatLng(element.lat, element.lon));
                  popupController.hideAllPopups();
                },
                icon: const Icon(Icons.navigation_rounded),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return RestaurantMenuPopUp(element: element);
                      });
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantScreen(restaurant: element)));
                },
                icon: const Icon(Icons.restaurant_menu_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RestaurantMenuPopUp extends StatefulWidget {
  const RestaurantMenuPopUp({
    super.key,
    required this.element,
  });

  final RestaurantModel element;

  @override
  State<RestaurantMenuPopUp> createState() => _RestaurantMenuPopUpState();
}

class _RestaurantMenuPopUpState extends State<RestaurantMenuPopUp> {
  List<DateTime> dates = [];
  int currentDateIndex = 0;
  List<MenuCrous>? menus;
  late PageController menuController;
  late PageController dateController;
  bool fromDate = false;
  bool fromMenu = false;

  @override
  void initState() {
    dates = widget.element.menus.map((e) => e.date).toList();
    dates.sort((a, b) => a.compareTo(b));
    currentDateIndex = 0;
    for (int i = 0; i < dates.length; i++) {
      if (!dates[i].shrink(3).isBefore(DateTime.now().shrink(3))) {
        currentDateIndex = i;
        break;
      }
    }

    menuController = PageController(initialPage: currentDateIndex);
    dateController = PageController(initialPage: currentDateIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 10,
            child: Text(
              AppLocalizations.of(context).menuOf(widget.element.name),
              maxLines: 3,
              softWrap: true,
            ),
          ),
          Flexible(
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              onTap: () async {
                if (await IzlyLogic.isRestaurantFavourite(widget.element)) {
                  await IzlyLogic.removeRestaurantToFavourite(widget.element);
                } else {
                  await IzlyLogic.addRestaurantToFavourite(widget.element);
                }
                setState(() {
                  context.read<AgendaCubit>().addRestaurant();
                });
              },
              child: FutureBuilder(
                  future: IzlyLogic.isRestaurantFavourite(widget.element),
                  builder: (context, snapshot) {
                    return Icon(
                        (snapshot.data ?? false)
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: Theme.of(context).colorScheme.primary);
                  }),
            ),
          ),
        ],
      ),
      content: (dates.isEmpty)
          ? Text(AppLocalizations.of(context).noMenuForThisRestaurant)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (currentDateIndex > 0) {
                          currentDateIndex--;
                          fromDate = true;
                          fromMenu = true;
                          dateController.animateToPage(
                            currentDateIndex,
                            duration: Res.animationDuration,
                            curve: Curves.easeIn,
                          );
                          menuController.animateToPage(
                            currentDateIndex,
                            duration: Res.animationDuration,
                            curve: Curves.easeIn,
                          );
                          Future.delayed(Res.animationDuration, () {
                            fromDate = false;
                            fromMenu = false;
                          });
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 5.h,
                        child: PageView(
                          controller: dateController,
                          onPageChanged: (i) async {
                            if (!fromMenu) {
                              currentDateIndex = i;
                              fromDate = true;
                              await menuController.animateToPage(
                                currentDateIndex,
                                duration: Res.animationDuration,
                                curve: Curves.easeIn,
                              );
                              fromDate = false;
                            }
                          },
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var d in dates)
                              Center(
                                child: Text(d.dateBeautifull(
                                    AppLocalizations.of(context).localeName)),
                              ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (currentDateIndex < dates.length - 1) {
                          currentDateIndex++;
                          fromDate = true;
                          fromMenu = true;
                          dateController.animateToPage(
                            currentDateIndex,
                            duration: Res.animationDuration,
                            curve: Curves.easeIn,
                          );
                          menuController.animateToPage(
                            currentDateIndex,
                            duration: Res.animationDuration,
                            curve: Curves.easeIn,
                          );
                          Future.delayed(Res.animationDuration, () {
                            fromDate = false;
                            fromMenu = false;
                          });
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
                if (widget.element.menus.isNotEmpty)
                  Expanded(
                    child: PageView(
                      controller: menuController,
                      onPageChanged: (i) async {
                        if (!fromDate) {
                          currentDateIndex = i;
                          fromMenu = true;
                          await dateController.animateToPage(
                            currentDateIndex,
                            duration: Res.animationDuration,
                            curve: Curves.easeIn,
                          );
                          fromMenu = false;
                        }
                      },
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var d in dates)
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                for (MenuCrous menuCrous in widget.element.menus
                                    .where(
                                        (element) => element.date.isSameDay(d))
                                    .toList())
                                  MenuWidget(menuCrous: menuCrous),
                              ],
                            ),
                          ),
                      ],
                      // builder: (context) {
                      //   return Expanded(
                      //     child: SingleChildScrollView(
                      //       child: Column(
                      //         children: [
                      //           for (MenuCrous menuCrous in menus!)
                      //             MenuWidget(menuCrous: menuCrous),
                      //         ],
                      //       ),
                      //     ),
                      //   );
                      // }
                    ),
                  ),
              ],
            ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context).close),
        )
      ],
    );
  }
}
