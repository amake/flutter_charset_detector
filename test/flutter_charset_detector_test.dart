import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_charset_detector');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'autoDecode':
          return {
            'string': utf8.decode(methodCall.arguments['data']),
            'encoding': utf8.name,
          };
        default:
          throw PlatformException();
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    final string = 'blah';
    final result = await CharsetDetector.autoDecode(utf8.encode(string));
    expect(result.encoding, 'utf-8');
    expect(result.string, string);
  });
}
