import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'integration_test_export.dart';

Future<void> mailTest(ConvenientTest t) async {
  await login(t);
  await find.byIcon(Icons.email_rounded).tap();
  for (var i = 1; i < 6; i++) {
    await find.text("senderMock$i").should(findsOneWidget);
    await find.text("subjectMock$i").should(findsOneWidget);
  }
  await find
      .text("Recherche dans les 20 derniers mails")
      .should(findsOneWidget);
  await find.byIcon(Icons.search_rounded).should(findsOneWidget);
  await find.text("2022/09/01").should(findsNWidgets(5));
  await find.text("Charger 20 messages de plus").should(findsOneWidget);
  await find.byIcon(Icons.create_rounded).should(findsOneWidget);

  //search for a mail
  await find.byType(TextField).enterTextWithoutReplace("senderMock1");
  await find.text("senderMock1").should(findsNWidgets(2));
  for (var i = 2; i < 6; i++) {
    await find.text("senderMock$i").should(findsNothing);
    await find.text("subjectMock$i").should(findsNothing);
  }
  await find.byType(TextField).replaceText("");
  //escape android keyboard
  await t.tester.testTextInput.receiveAction(TextInputAction.done);
  await t.tester.pumpAndSettle();

  for (var i = 1; i < 6; i++) {
    await find.text("senderMock$i").should(findsOneWidget);
    await find.text("subjectMock$i").should(findsOneWidget);
  }

  //toggle flag
  await find.byIcon(Icons.flag_rounded).should(findsNWidgets(2));
  await find.byIcon(Icons.outlined_flag_rounded).should(findsNWidgets(3));
  for (int i = 1; i < 6; i++) {
    await find.byKey(Key("email flag $i")).tap();
  }
  await find.byIcon(Icons.flag_rounded).should(findsNWidgets(3));
  await find.byIcon(Icons.outlined_flag_rounded).should(findsNWidgets(2));

  //read a mail
  await find.text("senderMock1").tap();
  await checkRead(t);

  //reply to mail
  await find.byIcon(Icons.reply_rounded).tap();
  await find.text("reponse").should(findsOneWidget);
  await find.text("Message").should(findsOneWidget);
  await find.text("bodyMock1").should(findsOneWidget);
  await find.text("Ajouter\n une pièce jointe").should(findsOneWidget);
  await find.byIcon(Icons.send_rounded).should(findsOneWidget);

  await find.byIcon(Icons.send_rounded).tap();
  await find
      .text("Veuillez remplir correctement tous les champs")
      .should(findsOneWidget);
  await t.tester.tapAt(const Offset(0, 0));
  await find
      .byType(TextField)
      .enterTextWithoutReplace("an answer example with blablablablablbablbala");
  await find
      .text("an answer example with blablablablablbablbala")
      .should(findsOneWidget);

  await find.byIcon(Icons.send_rounded).tap();
  await checkRead(t);

  //go back to main
  await find.byIcon(Icons.arrow_back_rounded).tap();
  for (var i = 1; i < 6; i++) {
    await find.text("senderMock$i").should(findsOneWidget);
    await find.text("subjectMock$i").should(findsOneWidget);
  }
}

Future<void> checkRead(ConvenientTest t) async {
  await find.byIcon(Icons.arrow_back_rounded).should(findsOneWidget);
  await find.byIcon(Icons.reply_rounded).should(findsOneWidget);
  await find.byIcon(Icons.reply_all_rounded).should(findsOneWidget);
  await find.text("de: senderMock1").should(findsOneWidget);
  await find.text("subjectMock1").should(findsOneWidget);
  await find.text("à: receiverMock1").should(findsOneWidget);
  await find.text("bodyMock1").should(findsOneWidget);
  await find.text("attachmentMock1").should(findsOneWidget);
  await find.text("attachmentMock2").should(findsOneWidget);
}
