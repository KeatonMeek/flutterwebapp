import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Tests expected return of anagram call",
      (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();
  });
}
