import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/widgets/core_widget_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key, this.enableBackButton = false});

  final bool enableBackButton;
  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        LatLng? center;
        if (state.status == MapStatus.initial) {
          context
              .read<MapCubit>()
              .loadBatiment(Locale(AppLocalizations.of(context).localeName));
        }
        if (state.status == MapStatus.batimentsUpdated &&
            state.path.isNotEmpty) {
          center = state.path.first;
        }
        return CommonScreenWidget(
          header: Row(
            children: [
              if (enableBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              Flexible(
                child: MapSearchAutocompleteWidget(
                  controller: textEditingController,
                ),
              ),
            ],
          ),
          body: MapWidget(
            batiments: state.batiments,
            restaurant: state.restaurant,
            center: center,
            polylines: [
              Polyline(
                points: state.path,
                strokeWidth: 4.0,
                color: Colors.red,
              ),
            ],
            onTapNavigate: (LatLng latLng) {
              context.read<MapCubit>().navigate(context, latLng);
            },
          ),
        );
      },
    );
  }
}
