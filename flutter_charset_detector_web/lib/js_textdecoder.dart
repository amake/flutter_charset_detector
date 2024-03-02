@JS()
library js_textdecoder;

import 'package:js/js.dart';

@JS()
class TextDecoder {
  external TextDecoder([String label, TextDecoderOptions options]);
  external String decode(dynamic data, [TextDecodeOptions options]);
  external String get encoding;
  external bool get fatal;
  external bool get ignoreBOM;
}

@JS()
@anonymous
class TextDecoderOptions {
  external bool get fatal;
  external bool get ignoreBOM;
  external factory TextDecoderOptions({bool fatal, bool ignoreBOM});
}

@JS()
@anonymous
class TextDecodeOptions {
  external bool get stream;
  external factory TextDecodeOptions({bool stream});
}
