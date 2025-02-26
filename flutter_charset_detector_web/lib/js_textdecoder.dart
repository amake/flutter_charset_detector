@JS()
library js_textdecoder;

import 'dart:js_interop';

extension type TextDecoder._(JSObject o) implements JSObject {
  external TextDecoder([String label, TextDecoderOptions options]);
  external String decode(JSAny data, [TextDecodeOptions options]);
  external String get encoding;
  external bool get fatal;
  external bool get ignoreBOM;
}

extension type TextDecoderOptions._(JSObject o) implements JSObject {
  external TextDecoderOptions({bool fatal, bool ignoreBOM});
  external bool get fatal;
  external bool get ignoreBOM;
}

extension type TextDecodeOptions._(JSObject o) implements JSObject {
  external TextDecodeOptions({bool stream});
  external bool get stream;
}
