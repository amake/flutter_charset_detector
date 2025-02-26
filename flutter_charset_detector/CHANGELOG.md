## 5.0.0

* Web implementation now requires Dart 3.3+

## 4.0.0

* Android implementation now requires SDK 21

## 3.1.0

* Add `detect` method to obtain the detected charset without decoding the
  supplied bytes

## 3.0.0

* Add macOS implementation
* iOS implementation now requires iOS 11+

## 2.1.0

* Add web implementation

## 2.0.0

* Drop older Android Gradle Plugin support

## 1.0.2

* Migrate to federated architecture

## 1.0.1

* Fix incompatibility with Kotlin <1.3.70
  ([#1](https://github.com/amake/flutter_charset_detector/issues/1))

## 1.0.0

* Migrate to non-nullable by default

## 0.3.0

* Update Android detection library
  * juniversalchardet 2.4.0

## 0.2.0

* Update iOS detection library
  * UniversalDetector2 2.0.0 (uchardet 0.0.7)

## 0.1.1

* Fleshed out package description

## 0.1.0

* Rename `DecodingResult.encoding` to `.charset`
* `DecodingResult.fromJson` constructor is now private
* Document public APIs

## 0.0.1

* Initial release
  * juniversalchardet 2.3.2
  * UniversalDetector 1.4.0 (uchardet pre-0.0.2 (84e292))
