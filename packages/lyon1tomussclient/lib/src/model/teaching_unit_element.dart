import 'package:equatable/equatable.dart';
import 'package:lyon1tomussclient/src/parser/dateparser.dart';

abstract class TeachingUnitElement extends Equatable {
  late final String title;
  late final String author;
  late final DateTime? date;
  late final double position;

  TeachingUnitElement({
    this.title = "",
    this.author = "",
    this.date,
    this.position = 0,
  });

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
