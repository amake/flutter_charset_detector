import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class CharsetDetector {
  static const MethodChannel _channel =
      MethodChannel('flutter_charset_detector');

  /// Automatically detect the charset of [bytes] and decode to a string.
  static Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final result =
        await _channel.invokeMethod<Map>('autoDecode', {'data': bytes}) as Map;
    return DecodingResult._fromJson(result.cast<String, dynamic>());
  }
}

/// The result of decoding bytes to a string
class DecodingResult {
  DecodingResult._fromJson(Map<String, dynamic> json)
      : this._(
          json['charset'] as String,
          json['string'] as String,
        );

  DecodingResult._(this.charset, this.string);

  /// The original charset of [string]
  final String charset;

  /// The decoded string
  final String string;
}
