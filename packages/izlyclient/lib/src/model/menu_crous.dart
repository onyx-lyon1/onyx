import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/menu_crous.g.dart';

// extension ToString on MenuType {
//   String toString() {}
// }

enum MenuType {
  matin,
  midi,
  soir;

  @override
  String toString() => name;
}

@CopyWith()
class MenuCrous extends Equatable {
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

  @override
  List<Object?> get props => [date, type, plats];

  @override
  bool get stringify => true;
}

@CopyWith()
class PlatCrous extends Equatable {
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

  @override
  List<Object?> get props => [name, variants];

  @override
  bool get stringify => true;
}
