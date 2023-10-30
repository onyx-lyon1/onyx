part of 'map_cubit.dart';

@MappableEnum()
enum MapStatus {
  @MappableValue(000)
  initial,
  @MappableValue(100)
  batimentsUpdated,
  @MappableValue(200)
  loading,
  @MappableValue(300)
  error
}

@MappableClass()
class MapState with MapStateMappable{
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
}
