import 'package:dart_mappable/dart_mappable.dart';

part 'kholle.mapper.dart';

@MappableClass()
class Kholle with KholleMappable {
  final DateTime date;
  final String subject;
  final String kholleur;
  final String? message;
  final String? room;

  Kholle(this.date, this.subject, this.kholleur, this.message, this.room);
}
