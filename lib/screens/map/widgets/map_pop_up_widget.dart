import 'package:flutter/material.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:onyx/screens/map/map_export.dart';

class MapPopupWidget extends StatelessWidget {
  const MapPopupWidget(
      {Key? key,
      required this.batiment,
      required this.onTap,
      required this.popupController})
      : super(key: key);
  final BatimentModel batiment;
  final void Function(BatimentModel) onTap;
  final PopupController popupController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(batiment.name, style: Theme.of(context).textTheme.bodyText1),
          IconButton(
            onPressed: () {
              onTap(batiment);
              popupController.hideAllPopups();
            },
            icon: const Icon(Icons.navigation_rounded),
          )
        ],
      ),
    );
  }
}
