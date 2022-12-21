import 'package:flutter/material.dart';
import 'package:oloid2/screens/map/map_export.dart';
import 'package:sizer/sizer.dart';

class MapSearchAutocompleteWidget extends StatelessWidget {
  const MapSearchAutocompleteWidget({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        return (await BatimentsLogic.findBatiment(textEditingValue.text))
            .map((e) => e.name);
      },
      textEditingController: controller,
      focusNode: FocusNode(),
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            color: Theme.of(context).backgroundColor,
            child: ListView(
              padding: EdgeInsets.all(1.h),
              shrinkWrap: true,
              children: options
                  .map((String option) => GestureDetector(
                        onTap: () {
                          onSelected(option);
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
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(100),
          ),
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: Theme.of(context).textTheme.button!.color!,
            style: TextStyle(
              color: Theme.of(context).textTheme.button!.color!,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              hintText: "Batiment",
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.5)),
              isDense: true,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}
