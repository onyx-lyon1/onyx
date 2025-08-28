import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';

part 'generated/agenda.g.dart';

@CopyWith()
@HiveType(typeId: 2)
class Agenda extends Equatable {
  @HiveField(0)
  late final List<Day> days;

  Agenda(this.days);

  Agenda.empty() {
    days = [];
  }

  @override
  List<Object?> get props => [days];

  @override
  bool get stringify => true;
}
