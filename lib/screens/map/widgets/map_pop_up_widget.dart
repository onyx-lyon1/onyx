import 'package:flutter/material.dart';
import 'package:oloid2/screens/map/map_export.dart';

class MapPopupWidget extends StatelessWidget {
  const MapPopupWidget({Key? key, required this.batiment}) : super(key: key);

  final BatimentModel batiment;

  @override
  Widget build(BuildContext context) {
    print("builder");
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(batiment.name),
      ),
    );
  }
}
