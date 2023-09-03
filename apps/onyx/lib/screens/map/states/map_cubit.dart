import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/map/map_export.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  Future<void> navigate(BuildContext context, LatLng latLng) async {
    List<List<LatLng>> paths =
        await NavigationLogic.navigateToBatimentFromLocation(
      context,
      [latLng],
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
    emit(state.copyWith(batiments: BatimentsLogic.batiments));
    List<RestaurantModel> restaurant;
    if (await CacheService.exist<List<RestaurantModel>>()) {
      restaurant = (await CacheService.get<List<RestaurantModel>>())!;
      emit(state.copyWith(
          restaurant: restaurant, status: MapStatus.batimentsUpdated));
    }
    restaurant = await IzlyClient.getRestaurantCrous();
    emit(state.copyWith(
        restaurant: restaurant, status: MapStatus.batimentsUpdated));
    await CacheService.set<List<RestaurantModel>>(restaurant);
  }

  void resetCubit() {
    emit(MapState(status: MapStatus.initial));
  }
}
