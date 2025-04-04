# flutter_charset_detector

Automatically detect and decode the charset (character encoding) of text bytes.

<img width="300" src="https://pbs.twimg.com/media/EhnW3CvU4AAz03s?format=png&name=4096x4096">

_The example app; [details](./example/README.md)_

This plugin uses native libraries derived from the universal charset detection
libraries created by Mozilla.

- iOS, macOS:
  [UniversalDetector2](https://cocoapods.org/pods/UniversalDetector2), a thin
  wrapper around [uchardet](https://www.freedesktop.org/wiki/Software/uchardet/)
- Android:
  [juniversalchardet](https://github.com/albfernandez/juniversalchardet), a Java
  implementation of universalchardet
- Web: [jschardet](https://github.com/aadsm/jschardet), a JavaScript port of the
  Python [chardet](https://github.com/chardet/chardet)

## Supported platforms

- Android 4.1 (SDK 16) and higher
- iOS 11 and higher
- macOS 10.14 and higher
- Web (requires [TextDecoder](https://caniuse.com/textencoder) support)

## Supported charsets

The detectable charsets differ by platform according to the capabilities of the
underlying library; for specifics see:

- [iOS, macOS](https://gitlab.freedesktop.org/uchardet/uchardet/-/blob/v0.0.8/README.md#supported-languagesencodings)
- [Android](https://github.com/albfernandez/juniversalchardet/blob/v2.5.0/README.md#encodings-that-can-be-detected)
- [Web](https://github.com/aadsm/jschardet/blob/v3.1.0/README.md#supported-charsets)

## Setup

- [Web](https://github.com/amake/flutter_charset_detector/tree/master/flutter_charset_detector_web#usage)
- Others: no special setup required

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
