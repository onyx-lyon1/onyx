import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';

part 'agenda.mapper.dart';

@MappableClass()
class Agenda with AgendaMappable {
  late final List<Day> days;

  Agenda(this.days);

  Agenda.empty() {
    days = [];
  }
}
