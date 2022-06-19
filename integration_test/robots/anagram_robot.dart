//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class AnagramRobot {
  const AnagramRobot(this.tester);

  final WidgetTester tester;

  Future<void> inputTextField(String text) async {
    await tester.pumpAndSettle();
    final anagramFormField = find.byKey(const Key("anagram"));
    await tester.enterText(anagramFormField, text);
  }

  Future<void> pressSubmit() async {
    await tester.pumpAndSettle();
    final submitButton = find.byKey(const Key("submit"));
    await tester.tap(submitButton);
  }
}
