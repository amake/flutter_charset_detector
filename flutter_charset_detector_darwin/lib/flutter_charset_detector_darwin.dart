import 'package:flutter/services.dart';
import 'package:flutter_charset_detector_platform_interface/decoding_result.dart';
import 'package:flutter_charset_detector_platform_interface/flutter_charset_detector_platform_interface.dart';

class CharsetDetectorDarwin extends CharsetDetectorPlatform {
  /// The method channel used to interact with the native platform.
  static const MethodChannel _channel =
      MethodChannel('flutter_charset_detector');

  /// Registers this class as the default instance of [CharsetDetectorPlatform]
  static void registerWith() =>
      CharsetDetectorPlatform.instance = CharsetDetectorDarwin();

  /// Automatically detect the charset of [bytes] and decode to a string.
  @override
  Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final result = await _channel
        .invokeMethod<Map<dynamic, dynamic>>('autoDecode', {'data': bytes});
    return DecodingResult.fromJson(result!.cast());
  }

  /// Detect and return the charset of [bytes].
  Future<String> detect(Uint8List bytes) async {
    return (await _channel.invokeMethod<String>('detect', {'data': bytes}))!;
  }
}
