
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterCharsetDetector {
  static const MethodChannel _channel =
      const MethodChannel('flutter_charset_detector');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
