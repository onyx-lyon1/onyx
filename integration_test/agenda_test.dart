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
  await find.text("mockDescription1").should(findsOneWidget);
  await find.text("mockDescription2").should(findsOneWidget);
  await find.text("mockDescription3").should(findsOneWidget);
  await find.text("01:00 • Déambu").should(findsOneWidget);
  await find.text("01:00 • Thémis").should(findsOneWidget);
  await find.text("01:00 • Nautibus").should(findsOneWidget);
  await find.text("08:00").should(findsOneWidget);
  await find.text("09:00").should(findsNWidgets(2));
  await find.text("10:00").should(findsNWidgets(2));
  await find.text("11:00").should(findsOneWidget);
  await find.text("3 événement(s)").should(findsOneWidget);
  await find
      .text(
        "${DateTime(DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0), 9, 1).toWeekDayName()} ${1} Septembre",
      )
      .should(findsOneWidget);

  //check detail of the first event
  await find.text('mockDescription1').tap();
  await find.text("Détail de l'événement").should(findsOneWidget);
  await find.text("mockDescription1").should(findsNWidgets(2));
  await find.text("08h00 09h00").should(findsOneWidget);
  await find.text("Déambu").should(findsOneWidget);
  await find
      .text(
        "${DateTime(DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0), 9, 1).toWeekDayName()} ${1} Septembre",
      )
      .should(findsNWidgets(2));
  await find.text("Itinéraire").should(findsOneWidget);

  //test gps
  await find.byType(PolylineLayer).should(findsNothing);
  await find.textContaining("Itinéraire").should(findsOneWidget);
  await find.textContaining("Itinéraire").tap();
  await find.byType(PolylineLayer).should(findsOneWidget);

  //quit and check we are on agenda page
  await find.byIcon(Icons.arrow_upward_rounded).tap();
  await find.text('mockDescription1').should(findsOneWidget);
}
