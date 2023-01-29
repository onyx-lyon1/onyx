import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:sizer/sizer.dart';

class MapSearchAutocompleteWidget extends StatelessWidget {
  const MapSearchAutocompleteWidget(
      {Key? key, required this.controller, this.mapController})
      : super(key: key);
  final TextEditingController controller;
  final MapController? mapController;

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    onTap(String option) {
      //needed because the context is not passed in the onSelected basic callback
      focusNode.unfocus();
      context.read<MapCubit>().navigate(
          context,
          context
              .read<MapCubit>()
              .state
              .batiments
              .firstWhere((element) => element.name == option),
          mapController);
    }

    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        return (await BatimentsLogic.findBatiment(textEditingValue.text))
            .map((e) => e.name);
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
              hintText: "Batiment",
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
