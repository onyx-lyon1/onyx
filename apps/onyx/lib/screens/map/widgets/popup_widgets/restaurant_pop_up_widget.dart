import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
        color: Theme.of(context).colorScheme.background,
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
              Text(element.name, style: Theme.of(context).textTheme.bodyLarge),
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

  @override
  void initState() {
    dates = widget.element.menus.map((e) => e.date).toList();
    dates.sort((a, b) => a.compareTo(b));
    for (int i = 0; i < dates.length; i++) {
      if (!dates[i].shrink(3).isBefore(DateTime.now().shrink(3))) {
        currentDateIndex = i;
        break;
      }
    }
    menus = widget.element.menus
        .where((element) => element.date.isSameDay(dates[currentDateIndex]))
        .toList();
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
              "menu de : ${widget.element.name}",
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
          ? const Text("Aucun menu pour ce restaurant")
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (currentDateIndex > 0) {
                            currentDateIndex--;
                            menus = widget.element.menus
                                .where((element) => element.date
                                    .isSameDay(dates[currentDateIndex]))
                                .toList();
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(dates[currentDateIndex].dateBeautifull()),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (currentDateIndex < dates.length - 1) {
                            currentDateIndex++;
                            menus = widget.element.menus
                                .where((element) => element.date
                                    .isSameDay(dates[currentDateIndex]))
                                .toList();
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
                if (menus != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (MenuCrous menuCrous in menus!)
                            MenuWidget(menuCrous: menuCrous),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Fermer"),
        )
      ],
    );
  }
}
