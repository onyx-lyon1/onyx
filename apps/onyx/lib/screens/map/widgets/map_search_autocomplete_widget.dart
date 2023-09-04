import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/search/search_service.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MapSearchAutocompleteWidget extends StatelessWidget {
  const MapSearchAutocompleteWidget({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    onTap(String option) {
      //needed because the context is not passed in the onSelected basic callback
      focusNode.unfocus();
      int index = context
          .read<MapCubit>()
          .state
          .batiments
          .indexWhere((element) => element.name == option);
      if (index != -1) {
        context.read<MapCubit>().navigate(
            context, context.read<MapCubit>().state.batiments[index].position);
      } else {
        index = context
            .read<MapCubit>()
            .state
            .restaurant
            .indexWhere((element) => element.name == option);
        if (index != -1) {
          context.read<MapCubit>().navigate(
                context,
                LatLng(context.read<MapCubit>().state.restaurant[index].lat,
                    context.read<MapCubit>().state.restaurant[index].lon),
              );
        }
      }
    }

    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        return [
          for (BatimentModel batiment
              in context.read<MapCubit>().state.batiments)
            if (SearchService.isMatch(textEditingValue.text, batiment.name))
              batiment.name,
          for (RestaurantModel restau
              in context.read<MapCubit>().state.restaurant)
            if (SearchService.isMatch(textEditingValue.text, restau.name))
              restau.name,
        ];
      },
      textEditingController: controller,
      focusNode: focusNode,
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            color: Theme.of(context).colorScheme.background,
            child: ListView(
              padding: EdgeInsets.all(1.h),
              shrinkWrap: true,
              children: options
                  .map((String option) => GestureDetector(
                        onTap: () {
                          onSelected(option);
                          onTap(option);
                        },
                        child: ListTile(
                          title: Text(option),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(100),
          ),
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: Theme.of(context).textTheme.labelLarge!.color!,
            style: TextStyle(
              color: Theme.of(context).textTheme.labelLarge!.color!,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              hintText: "Bâtiment",
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.5)),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}
