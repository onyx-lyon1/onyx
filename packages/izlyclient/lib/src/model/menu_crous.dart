import 'package:dart_mappable/dart_mappable.dart';

part 'menu_crous.mapper.dart';

@MappableEnum()
enum MenuType {
  @MappableValue(000)
  matin,
  @MappableValue(100)
  midi,
  @MappableValue(200)
  soir;
}

@MappableClass()
class MenuCrous with MenuCrousMappable {
  final DateTime date;
  final MenuType type;
  final List<PlatCrous> plats;

  MenuCrous({
    required this.date,
    required this.type,
    required this.plats,
  });

  static MenuCrous fromJson(Map<String, dynamic> json, String date) {
    return MenuCrous(
        date: DateTime.parse(date),
        type: json["name"] == "matin"
            ? MenuType.matin
            : json["name"] == "midi"
                ? MenuType.midi
                : MenuType.soir,
        plats: (json["foodcategory"] as List)
            .map((e) => PlatCrous.fromJson(e))
            .toList()
        // plats: (json["foodcategory"][0]["dishes"] as List<dynamic>)
        //     .map((e) => PlatCrous.fromJson(e))
        //     .toList(),
        );
  }
}

@MappableClass()
class PlatCrous with PlatCrousMappable {
  final String name;
  final List<String> variants;

  PlatCrous({
    required this.name,
    required this.variants,
  });

  static PlatCrous fromJson(Map<String, dynamic> json) {
    return PlatCrous(
      //apply type
      name: json["name"],
      variants:
          (json["dishes"] as List).map((e) => e["name"] as String).toList(),
    );
  }
}
