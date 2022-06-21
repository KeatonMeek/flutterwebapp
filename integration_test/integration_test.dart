import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webapp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webapp/models/anagram_model.dart';
import 'package:webapp/services/anagram_service.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:test/test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  app.main();

  final submitButton = find.byKey(const Key("submit"));
  final anagramFormField = find.byKey(const Key("anagram"));
  testWidgets("Tests expected return of input Keaton from REST Api",
      (WidgetTester tester) async {
    Map<String, dynamic> caseKeaton = {
      "letters": "Keaton",
      "words": [
        "token",
        "taken",
        "atone",
        "note",
        "teak",
        "tank",
        "take",
        "neat",
        "knot",
        "tone",
        "aeon",
        "eon",
        "eat",
        "net",
        "not",
        "ton",
        "oak",
        "toe",
        "one",
        "ate",
        "ken",
        "tan",
        "ant",
        "tea",
        "ten",
        "to",
        "at",
        "on",
        "no",
        "an",
        "a"
      ]
    };

    var anagramModel = AnagramModel.fromJson(caseKeaton);
    AnagramService service = AnagramService();
    AnagramModel actualReturn = await service.getAnagram("Keaton");

    app.main();
    await tester.pumpAndSettle();
    await tester.enterText(anagramFormField, "Keaton");
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    if (anagramModel.toString() != actualReturn.toString()) {
      fail("Return Values from the test were not equal");
    }

    sleep(const Duration(seconds: 5));
  });

  testWidgets("tests return of welcome input from REST API",
      (WidgetTester tester) async {
    Map<String, dynamic> caseWelcome = {
      "letters": "welcome",
      "words": [
        "welcome",
        "come",
        "mole",
        "meow",
        "wee",
        "owl",
        "owe",
        "mow",
        "mew",
        "woe",
        "low",
        "lee",
        "ewe",
        "elm",
        "eel",
        "cow",
        "em",
        "we",
        "me",
        "m"
      ]
    };

    var anagramModel = AnagramModel.fromJson(caseWelcome);
    AnagramService service = AnagramService();
    AnagramModel actualReturn = await service.getAnagram("Welcome");

    app.main();
    await tester.pumpAndSettle();
    await tester.enterText(anagramFormField, "Welcome");
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    if (anagramModel.toString() != actualReturn.toString()) {
      fail("Return Values from the test were not equal");
    }

    sleep(const Duration(seconds: 5));
  });
}
