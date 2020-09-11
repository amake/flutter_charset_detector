import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class CharsetDetector {
  static const MethodChannel _channel =
      MethodChannel('flutter_charset_detector');

  static Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final result =
        await _channel.invokeMethod<Map>('autoDecode', {'data': bytes});
    return DecodingResult.fromJson(result.cast<String, dynamic>());
  }
}

class DecodingResult {
  DecodingResult.fromJson(Map<String, dynamic> json)
      : this._(json['encoding'] as String, json['string'] as String);

  DecodingResult._(this.encoding, this.string)
      : assert(encoding != null),
        assert(string != null);
  final String encoding;
  final String string;
}
