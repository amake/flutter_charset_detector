import 'dart:js_interop';

@JS('jschardet.detect')
external DetectedMap detect(JSAny data, OptionsMap? options);

@JS('jschardet.detectAll')
external JSArray<DetectedMap> detectAll(JSAny data, OptionsMap? options);

@JS('jschardet.enableDebug')
external void enableDebug();

extension type DetectedMap._(JSObject o) implements JSObject {
  external DetectedMap({String encoding, num confidence});
  external String get encoding;
  external num get confidence;
}

extension type OptionsMap._(JSObject o) implements JSObject {
  external OptionsMap(
      {num? minimumThreshold, JSArray<JSString>? detectEncodings});
  external num? get minimumThreshold;
  external JSArray<JSString>? get detectEncodings;
}
