import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:oloid2/core/widgets/core_widget_export.dart';
import 'package:oloid2/screens/map/map_export.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: SafeArea(
        child: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            if (state.status == MapStatus.initial) {
              context.read<MapCubit>().loadBatiment();
            }
            return CommonScreenWidget(
              header: Center(
                child: MapSearchAutocompleteWidget(
                  controller: TextEditingController(),
                ),
              ),
              body: MapWidget(
                batiments: state.batiments,
                polylines: [
                  Polyline(
                    points: state.path,
                    strokeWidth: 4.0,
                    color: Colors.red,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
