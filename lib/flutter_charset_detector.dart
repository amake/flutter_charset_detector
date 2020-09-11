import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class CharsetDetector {
  static const MethodChannel _channel =
      MethodChannel('flutter_charset_detector');

  static Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final result =
        await _channel.invokeMethod<Map>('autoDecode', {'data': bytes});
    return DecodingResult._fromJson(result.cast<String, dynamic>());
  }
}

class DecodingResult {
  DecodingResult._fromJson(Map<String, dynamic> json)
      : this._(
          json['charset'] as String,
          json['string'] as String,
        );

  DecodingResult._(this.charset, this.string)
      : assert(charset != null),
        assert(string != null);
  final String charset;
  final String string;
}
