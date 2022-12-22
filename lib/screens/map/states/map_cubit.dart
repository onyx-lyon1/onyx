import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:oloid2/screens/map/map_export.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  void navigate(BuildContext context, BatimentModel batiment) async {
    List<List<LatLng>> paths =
        await NavigationLogic.navigateToBatimentFromLocation(
      context,
      [batiment],
    );
    emit(
      state.copyWith(
        status: MapStatus.batimentsUpdated,
        path: (paths.isNotEmpty) ? paths.first : [],
      ),
    );
  }

  void loadBatiment() async {
    emit(state.copyWith(status: MapStatus.loading));
    if (BatimentsLogic.batiments.isEmpty) {
      await BatimentsLogic.loadBatiments();
    }
    emit(state.copyWith(
        status: MapStatus.batimentsUpdated,
        batiments: BatimentsLogic.batiments));
  }
}
