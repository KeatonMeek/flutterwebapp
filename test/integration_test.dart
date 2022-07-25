import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:integration_test/integration_test.dart';
import 'package:webapp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:js_util';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  app.main();

  final submitButton = ft.find.byKey(const Key("submit"));
  final anagramFormField = ft.find.byKey(const Key("anagram"));
  ft.testWidgets("Tests expected return of input Keaton from REST Api",
      (ft.WidgetTester tester) async {
    List<String> caseKeaton = [
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
    ];

    app.main();
    await tester.pumpAndSettle();
    await tester.enterText(anagramFormField, "Keaton");
    
    await tester.tap(submitButton);
    
    await tester.pumpAndSettle();
    
    for(String items in caseKeaton) {
      ft.expect(ft.find.textContaining(RegExp( r'(^| )' + items + r'(,|$)')),ft.findsOneWidget);
    }

  
  });

  /*
  ft.testWidgets("tests return of welcome input from REST API",
      (ft.WidgetTester tester) async {
    List<String> caseWelcome = {
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
      ft.fail("Return Values from the test were not equal");
    }

    sleep(const Duration(seconds: 5));
  });
  */
}
