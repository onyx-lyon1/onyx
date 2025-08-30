import 'package:dart_mappable/dart_mappable.dart';
import 'package:izlyclient/izlyclient.dart';

part 'generated/restaurant_list_model.mapper.dart';

@MappableClass()
class RestaurantListModel with RestaurantListModelMappable {
  List<RestaurantModel> restaurantList;

  RestaurantListModel({required this.restaurantList});
}
