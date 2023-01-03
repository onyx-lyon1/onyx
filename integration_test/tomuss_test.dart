import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'integration_test_export.dart';

Future<void> tomussTest(ConvenientTest t) async {
  await login(t);
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
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/tomuss/main.png'));

  await find.textContaining("Algèbre").tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/tomuss/algebre_details.png'));
  await t.tester.drag(find.text("Colle1"), const Offset(0, 400));
  await t.pumpAndSettle();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/tomuss/main.png'));

  await find.textContaining("PIX").tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/tomuss/pix_details.png'));
  await t.tester
      .drag(find.text("TD/comp1.2_5.2/noteQUEST"), const Offset(0, 400));
  await t.pumpAndSettle();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/tomuss/main.png'));
}
