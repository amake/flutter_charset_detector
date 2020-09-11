import 'package:flutter/material.dart';
import 'package:flutter_charset_detector_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Launch app', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(
      find.byWidgetPredicate((widget) =>
          widget is Text && widget.data.startsWith('Default Charset')),
      findsOneWidget,
    );
  });
}
