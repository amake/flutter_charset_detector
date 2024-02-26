import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_charset_detector_web/flutter_charset_detector_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _charsetDetectorWeb = CharsetDetectorWeb();
  String? _fileCharset;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _detectFileCharset(Uint8List bytes) async {
    String fileCharset;

    try {
      final decodingResult = await _charsetDetectorWeb.autoDecode(bytes);
      fileCharset = decodingResult.charset;
    } on PlatformException {
      fileCharset = 'Failed to get charset.';
    }

    if (!mounted) return;

    setState(() {
      _fileCharset = fileCharset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () async {
                    final filesResult = await FilePicker.platform
                        .pickFiles(type: FileType.any, withData: kIsWeb);

                    if (filesResult != null && filesResult.files.isNotEmpty) {
                      final fileInfoResults = filesResult.files.first;
                      _detectFileCharset(fileInfoResults.bytes!);
                    }
                  },
                  child: const Text('Select File')),
              Text('File Charset: $_fileCharset\n')
            ],
          ),
        ),
      ),
    );
  }
}
