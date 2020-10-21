# flutter_charset_detector

Automatically detect and decode the charset (character encoding) of text bytes.

<img width="300" src="https://pbs.twimg.com/media/EhnW3CvU4AAz03s?format=png&name=4096x4096">

_The example app; [details](./example/README.md)_

This plugin uses native libraries derived from the universal charset detection
libraries created by Mozilla.

- iOS: [UniversalDetector2](https://cocoapods.org/pods/UniversalDetector2), a
  thin wrapper around
  [uchardet](https://www.freedesktop.org/wiki/Software/uchardet/)
- Android:
  [juniversalchardet](https://github.com/albfernandez/juniversalchardet), a Java
  implementation of universalchardet

## Supported platforms

- Android 4.1 (SDK 16) and higher
- iOS 9 and higher

## Supported charsets

The detectable charsets differ by platform according to the capabilities of the
underlying library; for specifics see:

- [iOS](https://gitlab.freedesktop.org/uchardet/uchardet/-/blob/v0.0.7/README.md#supported-languagesencodings)
- [Android](https://github.com/albfernandez/juniversalchardet/blob/v2.3.2/README.md#encodings-that-can-be-detected)

## Usage

```dart
import 'package:flutter_charset_detector/flutter_charset_detector.dart';

Uint8List bytes = getBytes(); // bytes with unknown encoding
DecodingResult result = CharsetDetector.autoDecode(bytes);
print(result.charset); // => e.g. 'SHIFT_JIS'
print(result.string); // => e.g. '日本語'
```

## See also

- [charset_converter](https://pub.dev/packages/charset_converter) if you already
know the name of the charset you want to encode/decode
