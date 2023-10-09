import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:onyx/screens/map/states/map_cubit.dart';

class CustomCurrentLocationLayerWidget extends StatelessWidget {
  const CustomCurrentLocationLayerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
        buildWhen: (previous, current) =>
            previous.geolocationAutorisation != current.geolocationAutorisation,
        builder: (context, state) {
          if (state.geolocationAutorisation) {
            return CurrentLocationLayer();
          }
          return Container();
        });
  }
}
