import 'dart:async';

import 'package:flutter_charset_detector_example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('Launch app', (tester) async {
    await runZonedGuarded(() async {
      await tester.pumpWidget(const MyApp());
      expect(
        find.byWidgetPredicate((widget) =>
            widget is Text && widget.data!.startsWith('Default Charset')),
        findsOneWidget,
      );
    }, (error, stack) {
      expectSync(error, isA<FormatException>());
    });
  });
}
