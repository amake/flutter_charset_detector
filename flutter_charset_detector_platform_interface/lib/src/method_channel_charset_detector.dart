import 'package:flutter/services.dart';
import 'package:flutter_charset_detector_platform_interface/decoding_result.dart';
import 'package:flutter_charset_detector_platform_interface/flutter_charset_detector_platform_interface.dart';

/// An implementation of [CharsetDetectorPlatform] that uses method channels.
class MethodChannelCharsetDetector extends CharsetDetectorPlatform {
  /// The method channel used to interact with the native platform.
  static const MethodChannel _channel =
      MethodChannel('flutter_charset_detector');

  /// Automatically detect the charset of [bytes] and decode to a string.
  @override
  Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final result = await _channel
        .invokeMethod<Map<dynamic, dynamic>>('autoDecode', {'data': bytes});
    return DecodingResult.fromJson(result!.cast());
  }

  /// Detect the charset of [bytes] and return just the encoding name.
  @override
  Future<String> detect(Uint8List bytes) async {
    return (await _channel.invokeMethod<String>('detect', {'data': bytes}))!;
  }
}
