import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'integration_test_export.dart';

Future<void> mailTest(ConvenientTest t) async {
  await login(t);
  await find.byIcon(Icons.email_rounded).tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/main.png'));

  //search for a mail
  await find.byType(TextField).enterTextWithoutReplace("senderMock1");
  await find.text("senderMock1").should(findsNWidgets(2));
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/search.png'));
  await find.byType(TextField).replaceText("");
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/main.png'));

  //toggle flag
  for (int i = 1; i < 6; i++) {
    await find.byKey(Key("email flag $i")).tap();
  }
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/flag.png'));

  //read a mail
  await find.text("senderMock1").tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/read.png'));
  //reply to mail
  await find.byIcon(Icons.reply_rounded).tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/reply.png'));
  await find.byIcon(Icons.send_rounded).tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/send_error.png'));
  await t.tester.tapAt(const Offset(0, 0));
  await find
      .byType(TextField)
      .enterTextWithoutReplace("an answer example with blablablablablbablbala");
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/reply_filled.png'));
  await find.byIcon(Icons.send_rounded).tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/read.png'));

  //go back to main
  await find.byIcon(Icons.arrow_back_rounded).tap();
  await find
      .byType(MaterialApp)
      .should(matchesGoldenFile('golden/mail/main_with_read.png'));
}
