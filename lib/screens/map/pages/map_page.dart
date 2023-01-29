import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/map/map_export.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    final MapController mapController = MapController();
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state.status == MapStatus.initial) {
          context.read<MapCubit>().loadBatiment();
        }
        return CommonScreenWidget(
          header: Center(
            child: MapSearchAutocompleteWidget(
              controller: textEditingController,
              mapController: mapController,
            ),
          ),
          body: MapWidget(
            batiments: state.batiments,
            mapController: mapController,
            polylines: [
              Polyline(
                points: state.path,
                strokeWidth: 4.0,
                color: Colors.red,
              ),
            ],
            onTapNavigate: (batiment) {
              context
                  .read<MapCubit>()
                  .navigate(context, batiment, mapController);
            },
          ),
        );
      },
    );
  }
}
