import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'generated/menu_crous.g.dart';

// extension ToString on MenuType {
//   String toString() {}
// }

@HiveType(typeId: 34)
enum MenuType {
  @HiveField(0)
  matin,
  @HiveField(1)
  midi,
  @HiveField(2)
  soir;

  @override
  String toString() => name;
}

@HiveType(typeId: 35)
enum MenuRegime {
  @HiveField(0)
  normal,
  @HiveField(1)
  vegetarian,
  @HiveField(2)
  vegan,
  @HiveField(3)
  sansPorc,
  @HiveField(4)
  sansViande,
  @HiveField(5)
  sansPorcNiViande;

  @override
  String toString() => name;
}

@HiveType(typeId: 37)
enum MenuCrousType {
  @HiveField(0)
  entree,
  @HiveField(1)
  plat,
  @HiveField(2)
  dessert,
  @HiveField(3)
  sandwich,
  @HiveField(4)
  salade;

  @override
  String toString() => name;
}

@CopyWith()
@HiveType(typeId: 32)
class MenuCrous extends Equatable {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final MenuType type;
  @HiveField(3)
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

  @override
  List<Object?> get props => [date, type, plats];

  @override
  bool get stringify => true;
}

@CopyWith()
@HiveType(typeId: 36)
class PlatCrous extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
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

  @override
  List<Object?> get props => [name, variants];

  @override
  bool get stringify => true;
}
