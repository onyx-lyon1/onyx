import 'package:hive/hive.dart';
import 'package:izlyclient/izlyclient.dart';

part 'generated/restaurant_list_model.g.dart';

@HiveType(typeId: 39)
class RestaurantListModel {
  @HiveField(0)
  List<RestaurantModel> restaurantList;

  RestaurantListModel({required this.restaurantList});
}
