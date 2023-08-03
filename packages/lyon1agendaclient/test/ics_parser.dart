import 'dart:io';

import 'package:lyon1agendaclient/src/parser/agendaparser.dart';
import 'package:test/test.dart';

void main() async {
  test('parseICS', () async {
    final AgendaParser parser = AgendaParser();

    final List<String> files = [
      'test/data/chimie.ics',
      'test/data/licenceical.ics',
      'test/data/m2ical.ics',
      'test/data/random.ics',
      'test/data/random2.ics'
    ];

    for (final String filename in files) {
      final File file = File(filename);
      parser.parseICS(file.readAsStringSync());
    }
  });
}
