import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:flutter_map_marker_cluster_2/flutter_map_marker_cluster.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class BatimentPopupWidget extends StatelessWidget {
  const BatimentPopupWidget(
      {super.key,
      required this.element,
      required this.onTap,
      required this.popupController});

  final BatimentModel element;
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(element.name, style: Theme.of(context).textTheme.bodyLarge),
          IconButton(
            onPressed: () {
              onTap(element.position);
              popupController.hideAllPopups();
            },
            icon: const Icon(Icons.navigation_rounded),
          )
        ],
      ),
    );
  }
}
