import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';

import 'integration_test_export.dart';

Future<void> agendaTest(ConvenientTest t) async {
  await login(t);
  await find.byIcon(Icons.calendar_today_rounded).tap();
  //check we are on today page
  await find
      .text(
        "${DateTime.now().toWeekDayName()} ${DateTime.now().day} ${DateTime.now().toMonthName()}",
      )
      .should(findsOneWidget);

  //go on another day
  await find
      .byKey(
          Key(DateTime.now().add(const Duration(days: 3)).shrink(3).toString()))
      .tap();
  //check we are on a different day
  await find
      .text(
        "${DateTime.now().toWeekDayName()} ${DateTime.now().day} ${DateTime.now().toMonthName()}",
      )
      .should(findsNothing);

  //go today
  await find.byIcon(Icons.calendar_today_rounded).tap();
  //check we are on today page
  await find
      .text(
        "${DateTime.now().toWeekDayName()} ${DateTime.now().day} ${DateTime.now().toMonthName()}",
      )
      .should(findsOneWidget);

  //drag until we find 1 september
  await t.tester.dragUntilVisible(
      find.byKey(Key(DateTime(
              DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0), 9, 1)
          .toString())),
      find.byType(MiniCalendarWidget),
      const Offset(80, 0),
      maxIteration: 200);
  //check we are in september
  await find.text('Sept.').should(findsWidgets);
  //add delay
  await t.tester.pumpAndSettle();
  //go on 1 september
  await find
      .byKey(Key(DateTime(
              DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0), 9, 1)
          .toString()))
      .tap();
  //check we are on 1 september page
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/agenda/1_septembre.png'));
  await find
      .text(
        "${DateTime(DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0), 9, 1).toWeekDayName()} ${1} Septembre",
      )
      .should(findsOneWidget);

  //check detail of the first event
  await find.text('mockDescription1').tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/agenda/first_event_details.png'));
  await find.text('mockDescription1').should(findsNWidgets(2));

  //test gps
  await find.byType(PolylineLayer).should(findsNothing);
  await find.textContaining("Itinéraire").should(findsOneWidget);
  await find.textContaining("Itinéraire").tap();
  await find.byType(PolylineLayer).should(findsOneWidget);
  await find.byType(MaterialApp).should(
      matchesGoldenFile('golden/agenda/first_event_details_with_gps.png'));

  //quit and check we are on agenda page
  await find.byIcon(Icons.arrow_upward_rounded).tap();
  await find.text('mockDescription1').should(findsOneWidget);
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/agenda/1_septembre.png'));
}
