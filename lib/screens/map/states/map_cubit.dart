import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:oloid2/screens/map/domain/logic/geolocation_logic.dart';
import 'package:oloid2/screens/map/map_export.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  void navigateToBatiment(BatimentModel batiment) async {
    emit(
      state.copyWith(
        status: MapStatus.batimentsUpdated,
        path: await OsrmLogic.calculateRoute(
            await GeolocationLogic.getCurrentLocation(), batiment.position),
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
