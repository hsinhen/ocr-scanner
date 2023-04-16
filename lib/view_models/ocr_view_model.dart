import 'dart:async';

import 'package:flutter/material.dart';

class OcrViewModel extends ChangeNotifier {
  final StreamController _controller = StreamController();
  Stream get scannedText => _controller.stream;

  void setText(String value) {
    _controller.add(value);
  }

  void dispose() {
    _controller.close();
  }
}
