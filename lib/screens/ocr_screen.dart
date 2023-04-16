import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_ocr_scanner/view_models/ocr_view_model.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({Key key}) : super(key: key);

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  final OcrViewModel viewModel = OcrViewModel();
  ScalableOCR scalableOCR;

  @override
  void initState() {
    super.initState();
    scalableOCR = ScalableOCR(
      getScannedText: viewModel.setText,
      paintboxCustom: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = Color.fromARGB(153, 102, 160, 241),
      boxLeftOff: 5,
      boxBottomOff: 2.5,
      boxRightOff: 5,
      boxTopOff: 2.5,
      boxHeight: 400,
      getRawData: (value) {
        inspect(value);
      },
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ocr Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            scalableOCR,
            StreamBuilder(
              stream: viewModel.scannedText,
              builder: ((context, snapshot) {
                return Text(snapshot.data != null
                    ? 'Readed text: ${snapshot.data}'
                    : 'No result');
              }),
            )
          ],
        ),
      ),
    );
  }
}
