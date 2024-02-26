# flutter\_charset\_detector\_web

The Web implementation of [`flutter_charset_detector`][1].

## Usage

To make it work properly on the Web platform, you need to add the `jschardet.min.js` file inside the <head> of your `web/index.html` file:

```html
<head>
    <!-- ... -->
    <script type="application/javascript" src="/assets/packages/flutter_charset_detector_web/assets/web/jschardet.min.js" defer></script>
    <!-- ... -->
</head>
```

This package is [endorsed][2], which means you can simply use
`flutter_charset_detector` normally. This package will be automatically included
in your app when you do.

[1]: https://pub.dev/packages/flutter_charset_detector
[2]: https://flutter.dev/docs/development/packages-and-plugins/developing-packages#endorsed-federated-plugin
