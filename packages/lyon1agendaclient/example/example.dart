import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';

void main() async {
  final Lyon1AgendaClient agendaClient =
  Lyon1AgendaClient.useLyon1Cas(Lyon1CasClient());
  final Agenda? agendaOpt = await agendaClient.getAgenda(id: 10069);
  if (agendaOpt == null) {
    // handle gracefully
  }
  final Agenda agenda = agendaOpt ?? Agenda.empty();

  for (final Day day in agenda.days) {
    print(day.date.toString());
    for (final Event e in day.events) {
      print(e.name);
      print("\t${e.location} | ${e.teacher}");
      print("\t${e.start.toString()} -> ${e.end.toString()}");
    }
  }
}
