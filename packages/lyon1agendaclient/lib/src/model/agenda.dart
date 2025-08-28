import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';

part 'generated/agenda.g.dart';

@CopyWith()
class Agenda extends Equatable {
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
