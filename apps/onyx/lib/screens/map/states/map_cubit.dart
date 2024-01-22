import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:latlong2/latlong.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState()) {
    updateGeolocationAutorisation();
  }

  Future<void> navigate(BuildContext context, LatLng latLng) async {
    List<List<LatLng>> paths;
    if (!NavigationLogic.calculating) {
      NavigationLogic.calculating = true;
      paths = await NavigationLogic.navigateToBatimentFromLocation(
          context, [latLng],
          useLastLocation: false);
      NavigationLogic.calculating = false;
      emit(
        state.copyWith(
          status: MapStatus.batimentsUpdated,
          path: (paths.isNotEmpty) ? paths.first : [],
        ),
      );
    }
  }

  void loadBatiment(SettingsState settings) async {
    emit(state.copyWith(status: MapStatus.loading));
    List<BatimentModel> batiments = [];
    if (state.batiments.isEmpty) {
      batiments = await BatimentsLogic.loadBatiments(settings);
    }
    emit(state.copyWith(batiments: batiments));
    List<RestaurantModel> restaurant;
    if (await CacheService.exist<RestaurantListModel>()) {
      restaurant =
          (await CacheService.get<RestaurantListModel>())!.restaurantList;
      emit(state.copyWith(
          restaurant: restaurant, status: MapStatus.batimentsUpdated));
    }
    restaurant = await IzlyClient.getRestaurantCrous();
    emit(state.copyWith(
        restaurant: restaurant, status: MapStatus.batimentsUpdated));
    await CacheService.set<RestaurantListModel>(
        RestaurantListModel(restaurantList: restaurant));
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
