@JS()
library js_charset_detector;

import 'package:js/js.dart';

@JS('jschardet.detect')
external DetectedMap detect(dynamic data, OptionsMap? options);

@JS('jschardet.detectAll')
external List<DetectedMap> detectAll(dynamic data, OptionsMap? options);

@JS('jschardet.enableDebug')
external void enableDebug();

@JS()
@anonymous
class DetectedMap {
  external String get encoding;
  external num get confidence;
  external factory DetectedMap({String encoding, num confidence});
}

@JS()
@anonymous
class OptionsMap {
  external num? get minimumThreshold;
  external List<String>? get detectEncodings;
  external factory OptionsMap(
      {num? minimumThreshold, List<String>? detectEncodings});
}
