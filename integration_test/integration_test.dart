import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webapp/main.dart' as app;
import 'robots/anagram_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Tests expected return of anagram call from REST Api",
      (WidgetTester tester) async {
    app.main();

    AnagramRobot robot = AnagramRobot(tester);
    //sleep(const Duration(seconds: 5));
    await robot.inputTextField("Keaton");
    sleep(const Duration(seconds: 5));
    await robot.pressSubmit();
    sleep(const Duration(seconds: 5));
  });
}
