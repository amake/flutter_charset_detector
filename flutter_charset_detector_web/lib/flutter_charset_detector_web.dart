import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter_charset_detector_platform_interface/decoding_result.dart';
import 'package:flutter_charset_detector_platform_interface/flutter_charset_detector_platform_interface.dart';
import 'package:flutter_charset_detector_web/js_charset_detector.dart'
    as jschardet;
import 'package:flutter_charset_detector_web/js_textdecoder.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

const _textDecoderLabels = {
  'cp874': 'windows-874',
  'cp932': 'shift_jis',
  'cp949': 'euc-kr',
  'maccyrillic': 'x-mac-cyrillic',
  'macroman': 'macintosh',
  'utf-8-sig': 'utf-8',
};

class CharsetDetectorWeb extends CharsetDetectorPlatform {
  CharsetDetectorWeb() {
    if (kDebugMode) {
      jschardet.enableDebug();
    }
  }

  /// Registers this class as the default instance of [CharsetDetectorPlatform]
  static void registerWith(Registrar registrar) =>
      CharsetDetectorPlatform.instance = CharsetDetectorWeb();

  /// Automatically detect the charset of [bytes] and decode to a string.
  @override
  Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final byteString = String.fromCharCodes(bytes);
    final detectedMap = jschardet.detect(byteString.toJS);
    final detectedEncoding = _requireDetectedEncoding(detectedMap.encoding);
    final decoder = TextDecoder(_textDecoderLabel(detectedEncoding));
    debugPrint(
      'Detected result; '
      'encoding: $detectedEncoding (normalized to: ${decoder.encoding}), '
      'confidence: ${detectedMap.confidence}',
    );
    final decodedString = decoder.decode(bytes.toJS);
    return DecodingResult.fromJson({
      'charset': decoder.encoding,
      'string': decodedString,
    });
  }

  /// Detect and return the charset of [bytes].
  @override
  Future<String> detect(Uint8List bytes) async {
    final byteString = String.fromCharCodes(bytes);
    final detectedMap = jschardet.detect(byteString.toJS);
    return _requireDetectedEncoding(detectedMap.encoding);
  }

  String _requireDetectedEncoding(String? encoding) {
    if (encoding == null) {
      throw StateError('jschardet could not determine the input encoding.');
    }
    return encoding;
  }

  String _textDecoderLabel(String encoding) =>
      _textDecoderLabels[encoding.toLowerCase()] ?? encoding;
}
