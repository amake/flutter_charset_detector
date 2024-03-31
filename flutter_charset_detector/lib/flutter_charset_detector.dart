import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_charset_detector_platform_interface/decoding_result.dart';
import 'package:flutter_charset_detector_platform_interface/flutter_charset_detector_platform_interface.dart';

export 'package:flutter_charset_detector_platform_interface/decoding_result.dart';

CharsetDetectorPlatform get _platform => CharsetDetectorPlatform.instance;

// Legacy wrapper class for backwards compatibility
class CharsetDetector {
  /// Automatically detect the charset of [bytes] and decode to a string.
  static Future<DecodingResult> autoDecode(Uint8List bytes) =>
      _platform.autoDecode(bytes);

  /// Detect and return the charset of [bytes].
  static Future<String> detect(Uint8List bytes) => _platform.detect(bytes);
}
