# flutter_charset_detector_example

Demonstrates how to use the flutter_charset_detector plugin.

<img width="300" src="https://pbs.twimg.com/media/EhnW3CvU4AAz03s?format=png&name=4096x4096">

The app loads an asset file encoded in
[Shift-JIS](https://en.wikipedia.org/wiki/Shift_JIS) in three ways from top to
bottom:

1. Using the default encoding: Flutter's various load mechanisms by default
   assumes UTF-8, and fails if there are unrepresentable characters
2. Using UTF-8 with "allow malformed": Interpret the bytes as UTF-8 and replace
   any unrepresentable characters with U+FFFD (�)
3. With auto-detection through `CharsetDetector.autoDecode`: the result includes
   the detected charset and the decoded string
