import 'package:dart_mappable/dart_mappable.dart';
import 'package:izlyclient/izlyclient.dart';

part 'generated/restaurant.mapper.dart';

@MappableEnum()
enum CrousType { restaurant, cafet }

@MappableClass()
class RestaurantModel with RestaurantModelMappable {
  final int id;
  final String name;
  final String description;
  final String shortDescription;
  final CrousType type;
  final double lat;
  final double lon;
  final String opening;
  final List<MenuCrous> menus;
  final String imageUrl;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.type,
    required this.lat,
    required this.lon,
    required this.opening,
    required this.menus,
    required this.imageUrl,
  });

  static RestaurantModel fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json["id"],
      name: json["title"],
      description: json["description"],
      shortDescription: json["shortdesc"],
      type: json["type"] == "Restaurant"
          ? CrousType.restaurant
          : CrousType.cafet,
      lat: json["lat"],
      lon: json["lon"],
      opening: json["opening"],
      menus: [
        for (var e in json["menus"])
          for (var meal in e["meal"])
            MenuCrous.fromJson(meal, e["date"] as String),
      ],
      imageUrl: json["photo"]["src"],
    );
  }
}
