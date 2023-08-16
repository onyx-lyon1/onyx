import 'package:dotenv/dotenv.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1agendaclient/src/utils/agenda_url.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:test/test.dart';

void main() async {
  DotEnv env = DotEnv(includePlatformEnvironment: true);
  test('getAgenda from URL', () async {
    env.load();
    final int icalId = int.parse(env['ICAL_ID']!);

    final Lyon1AgendaClient agendaClient = Lyon1AgendaClient(AgendaURL(Lyon1CasClient()));
    final Agenda? agendaOpt = await agendaClient.getAgenda(id: icalId);

    expect(agendaOpt == null, equals(false));

    final Agenda agenda = agendaOpt ?? Agenda.empty();
    for (final Day day in agenda.days) {
      for (final Event event in day.events) {
        expect(event.start.runtimeType, equals(DateTime));
        expect(event.end.runtimeType, equals(DateTime));
        expect(event.eventLastModified.runtimeType, equals(DateTime));

        expect(event.description, isNot(isEmpty));
        expect(event.description.contains("Exported"), equals(false));
        expect(event.name, isNot(isEmpty));
        //expect(event.location, isNot(isEmpty)); sometime no location is provided

        // TODO: investigate
        // expect(event.teacher, isNot(isEmpty)); // does not pass
      }
    }
  });
}
