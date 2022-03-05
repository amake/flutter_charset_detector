# flutter\_charset\_detector\_platform\_interface

A common platform interface for the [`flutter_charset_detector`][1] plugin.

This interface allows platform-specific implementations of the
`flutter_charset_detector` plugin, as well as the plugin itself, to ensure they
are supporting the same interface.

# Usage

To implement a new platform-specific implementation of
`flutter_charset_detector`, extend [`CharsetDetectorPlatform`][2] with an
implementation that performs the platform-specific behavior, and when you
register your plugin, set the default `CharsetDetectorPlatform` by calling
`CharsetDetectorPlatform.instance = MyPlatformCharsetDetector()`.

[1]: ../
[2]: lib/flutter_charset_detector_platform_interface.dart
