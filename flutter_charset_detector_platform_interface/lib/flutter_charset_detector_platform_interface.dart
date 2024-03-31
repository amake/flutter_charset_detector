import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_charset_detector_platform_interface/decoding_result.dart';
import 'package:flutter_charset_detector_platform_interface/src/method_channel_charset_detector.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class CharsetDetectorPlatform extends PlatformInterface {
  /// Constructs a CharsetDetectorPlatform.
  CharsetDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static CharsetDetectorPlatform _instance = MethodChannelCharsetDetector();

  /// The default instance of [CharsetDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelCharsetDetector].
  static CharsetDetectorPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [CharsetDetectorPlatform] when they register
  /// themselves.
  static set instance(CharsetDetectorPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Automatically detect the charset of [bytes] and decode to a string.
  Future<DecodingResult> autoDecode(Uint8List bytes) =>
      throw UnimplementedError('autoDecode() has not been implemented.');

  /// Detect and return the charset of [bytes].
  Future<String> detect(Uint8List bytes) =>
      throw UnimplementedError('detect() has not been implemented.');
}
