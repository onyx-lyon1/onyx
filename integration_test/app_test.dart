import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onyx/app.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/extensions/weekday_to_string.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/main.dart' as app;
import 'package:onyx/screens/agenda/agenda_export.dart';

void main() {
  convenientTestMain(MyConvenientTestSlot(), () {
    group('end-to-end test', () {
      tTestWidgets('login', (t) async {
        Res.mock = true;
        await find.text("Connection").should(findsOneWidget);
        await find.text("Connection").tap();
        await find.text("Connection").should(findsNothing);
      });
      tTestWidgets('check notes', (t) async {
        await t.login();
        await find.text("Notes").should(findsOneWidget);
        await find.text("Algèbre 1 Cursus Prépa").should(findsOneWidget);
        await find.text("9.94").should(findsOneWidget);
        await find.text("WAGNER,  • grp ?").should(findsOneWidget);

        await find.text("20.0").should(findsNWidgets(2));

        await find
            .text("Compétences Numériques et Préparation PIX - Module 1")
            .should(findsOneWidget);
        await find.text("17.3").should(findsOneWidget);
        await find.text("TRILLAUD,  • grp ?").should(findsOneWidget);
      });
      tTestWidgets('test agenda', (t) async {
        await t.login();
        await find.byIcon(Icons.calendar_today_rounded).tap();
        //check we are on today page
        await find
            .text(
              "${DateTime.now().toWeekDayName()} ${DateTime.now().day} ${DateTime.now().toMonthName()}",
            )
            .should(findsOneWidget);

        //go on another day
        await find
            .byKey(Key(DateTime.now()
                .add(const Duration(days: 3))
                .shrink(3)
                .toString()))
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
                    DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0),
                    9,
                    1)
                .toString())),
            find.byType(MiniCalendarWidget),
            const Offset(80, 0),
            maxIteration: 200);
        //check we are in september
        await find.text('Sept.').should(findsWidgets);
        //go on 1 september
        await find
            .byKey(Key(DateTime(
                    DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0),
                    9,
                    1)
                .toString()))
            .tap();
        //check we are on 1 september page
        await find
            .text(
              "${DateTime(DateTime.now().year + ((DateTime.now().month < 6) ? -1 : 0), 9, 1).toWeekDayName()} ${1} Septembre",
            )
            .should(findsOneWidget);

        //check we have the right number of events
        await find.text('3 évènement(s)').should(findsOneWidget);
      });
    });
  });
}

class MyConvenientTestSlot extends ConvenientTestSlot {
  @override
  Future<void> appMain(AppMainExecuteMode mode) async => app.main();

  @override
  BuildContext? getNavContext(ConvenientTest t) =>
      OloidApp.navigatorKey.currentContext;
}

extension on ConvenientTest {
  Future<void> login() async {
    Res.mock = true;
    await find.text("Connection").tap();
  }
}
