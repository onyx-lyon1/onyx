import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:izlyclient/izlyclient.dart';

part 'generated/restaurant.g.dart';

@HiveType(typeId: 38)
enum CrousType {
  @HiveField(0)
  restaurant,
  @HiveField(1)
  cafet,
}

@CopyWith()
@HiveType(typeId: 33)
class RestaurantModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String shortDescription;
  @HiveField(4)
  final CrousType type;
  @HiveField(5)
  final double lat;
  @HiveField(6)
  final double lon;
  @HiveField(7)
  final String opening;
  @HiveField(8)
  final List<MenuCrous> menus;
  @HiveField(9)
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
      type:
          json["type"] == "Restaurant" ? CrousType.restaurant : CrousType.cafet,
      lat: json["lat"],
      lon: json["lon"],
      opening: json["opening"],
      menus: [
        for (var e in json["menus"])
          for (var meal in e["meal"])
            MenuCrous.fromJson(meal, e["date"] as String)
      ],
      imageUrl: json["photo"]["src"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        shortDescription,
        type,
        lat,
        lon,
        opening,
        menus,
        imageUrl
      ];

  @override
  bool get stringify => true;
}
