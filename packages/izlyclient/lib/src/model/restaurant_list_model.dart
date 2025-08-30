import 'package:izlyclient/izlyclient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/restaurant_list_model.g.dart';

@JsonSerializable()
class RestaurantListModel {
  List<RestaurantModel> restaurantList;

  RestaurantListModel({required this.restaurantList});
}
