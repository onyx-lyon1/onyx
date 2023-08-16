import 'package:lyon1tomussclient/src/parser/dateparser.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

abstract class TeachingUnitElement extends Equatable {
  @HiveField(100, defaultValue: "")
  late final String title;
  @HiveField(101, defaultValue: "")
  late final String author;
  @HiveField(102, defaultValue: null)
  late final DateTime? date;
  @HiveField(103, defaultValue: 0)
  late final double position;

  TeachingUnitElement(
      {required this.title,
      required this.author,
      required this.date,
      required this.position});

  TeachingUnitElement.fromJson(
      var id, var json, var stats, var line, var column, String user) {
    title = json['title'] ?? "";
    author = json['author'] ?? "";
    if (line[id].length > 2) {
      String dateString = line[id][2].toString();
      date = dateString.toDateTime();
    } else {
      date = null;
    }
    position = json['position'].toDouble() ?? 0;
  }

  bool get isVisible;

  List<Object?> get customProps;

  @override
  List<Object?> get props => [title, author, date, position, ...customProps];
  @override
  bool? get stringify => true;
}

// @HiveType(typeId: 12)
// class CustomElement extends TeachingUnitElement {
//   // Ajoutez ici les propriétés spécifiques à CustomElement
//
//   CustomElement.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
//     coucou = json['coucou'];
//   }
//
//   CustomElement({required super.name, required this.coucou});
//
//   @override
//   bool get isVisible => false;
//
//   @override
//   List<Object?> get customProps => [coucou];
// }
