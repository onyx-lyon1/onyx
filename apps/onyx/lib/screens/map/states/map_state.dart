part of 'map_cubit.dart';

enum MapStatus { initial, batimentsUpdated, loading, error }

class MapState {
  final MapStatus status;
  final List<BatimentModel> batiments;
  final List<RestaurantModel> restaurant;
  final List<LatLng> path;
  final bool geolocationAutorisation;

  MapState({
    this.status = MapStatus.initial,
    this.batiments = const [],
    this.path = const [],
    this.restaurant = const [],
    this.geolocationAutorisation = false,
  });

  MapState copyWith({
    MapStatus? status,
    List<BatimentModel>? batiments,
    List<LatLng>? path,
    List<RestaurantModel>? restaurant,
    bool? geolocationAutorisation,
  }) {
    return MapState(
      status: status ?? this.status,
      batiments: batiments ?? this.batiments,
      path: path ?? this.path,
      restaurant: restaurant ?? this.restaurant,
      geolocationAutorisation:
          geolocationAutorisation ?? this.geolocationAutorisation,
    );
  }

  @override
  String toString() {
    return 'MapState{status: $status, batiments: $batiments, restaurant: $restaurant, path: $path, geolocationAutorisation: $geolocationAutorisation}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          listEquals(batiments, other.batiments) &&
          listEquals(path, other.path) &&
          listEquals(restaurant, other.restaurant) &&
          geolocationAutorisation == other.geolocationAutorisation;

  @override
  int get hashCode =>
      status.hashCode ^
      batiments.hashCode ^
      restaurant.hashCode ^
      path.hashCode ^
      geolocationAutorisation.hashCode;
}
