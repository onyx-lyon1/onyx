import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onyx/app.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/main.dart' as app;

import 'integration_test_export.dart';

void main() {
  convenientTestMain(MyConvenientTestSlot(), () {
    group('end-to-end test', () {
      tTestWidgets('login', (t) async {
        Res.mock = true;
        await find.text("Connection").should(findsOneWidget);
        await find.text("Connection").tap();
        await find.text("Connection").should(findsNothing);
      });
      tTestWidgets('check notes', tomussTest);
      tTestWidgets('test agenda', agendaTest);
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

Future<void> login(ConvenientTest t) async {
  Res.mock = true;
  await find.text("Connection").tap();
}
