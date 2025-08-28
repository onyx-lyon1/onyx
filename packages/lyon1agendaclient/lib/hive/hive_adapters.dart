import 'package:hive_ce/hive.dart';
import 'package:lyon1agendaclient/src/model/agenda.dart';
import 'package:lyon1agendaclient/src/model/day.dart';
import 'package:lyon1agendaclient/src/model/event.dart';

@GenerateAdapters([
  AdapterSpec<Day>(),
  AdapterSpec<Agenda>(),
  AdapterSpec<Event>(),
])
part 'generated/hive_adapters.g.dart';
