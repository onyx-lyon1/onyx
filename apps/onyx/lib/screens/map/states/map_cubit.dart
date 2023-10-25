import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/map/map_export.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState()) {
    updateGeolocationAutorisation();
  }

  Future<void> navigate(BuildContext context, LatLng latLng) async {
    List<List<LatLng>> paths;
    if (GeolocationLogic.lastLocation != null) {
      paths = await NavigationLogic.navigateToBatimentFromLocation(
          context, [latLng],
          useLastLocation: true);
      emit(
        state.copyWith(
          status: MapStatus.batimentsUpdated,
          path: (paths.isNotEmpty) ? paths.first : [],
        ),
      );
    }
    // ignore: use_build_context_synchronously
    paths = await NavigationLogic.navigateToBatimentFromLocation(
        context, [latLng],
        useLastLocation: false);
    emit(
      state.copyWith(
        status: MapStatus.batimentsUpdated,
        path: (paths.isNotEmpty) ? paths.first : [],
      ),
    );
  }

  void loadBatiment() async {
    emit(state.copyWith(status: MapStatus.loading));
    List<BatimentModel> batiments = [];
    if (state.batiments.isEmpty) {
      batiments = await BatimentsLogic.loadBatiments();
    }
    emit(state.copyWith(batiments: batiments));
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

  Future<bool> updateGeolocationAutorisation() async {
    if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS))) {
      var permission = await Geolocator.checkPermission();
      bool result = [LocationPermission.whileInUse, LocationPermission.always]
              .contains(permission) &&
          await Geolocator.isLocationServiceEnabled();
      emit(state.copyWith(geolocationAutorisation: result));
      return result;
    } else {
      emit(state.copyWith(geolocationAutorisation: false));
      return false;
    }
  }

  Future<bool> askGeolocationAutorisation() async {
    await Geolocator.requestPermission();
    return await updateGeolocationAutorisation();
  }

  void resetCubit() {
    emit(MapState(status: MapStatus.initial));
  }
}
