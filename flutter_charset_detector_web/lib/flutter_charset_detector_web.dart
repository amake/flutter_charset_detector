import 'package:flutter/foundation.dart';
import 'package:flutter_charset_detector_platform_interface/decoding_result.dart';
import 'package:flutter_charset_detector_platform_interface/flutter_charset_detector_platform_interface.dart';
import 'package:flutter_charset_detector_web/js_charset_detector.dart'
    as js_charset;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class CharsetDetectorWeb extends CharsetDetectorPlatform {
  CharsetDetectorWeb() {
    if (kDebugMode) {
      js_charset.enableDebug();
    }
  }

  /// Registers this class as the default instance of [CharsetDetectorPlatform]
  static void registerWith(Registrar registrar) =>
      CharsetDetectorPlatform.instance = CharsetDetectorWeb();

  /// Automatically detect the charset of [bytes] and decode to a string.
  @override
  Future<DecodingResult> autoDecode(Uint8List bytes) async {
    String text = String.fromCharCodes(bytes);
    final detectedMap = js_charset.detect(text, null);
    return DecodingResult.fromJson({
      'charset': detectedMap.encoding,
      'string': text,
    });
  }
}
