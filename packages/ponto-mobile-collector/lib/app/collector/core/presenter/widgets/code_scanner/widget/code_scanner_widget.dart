import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import '../cubit/code_scanner_cubit.dart';
import 'code_camera_widget.dart';

class CodeScannerWidget extends StatefulWidget {
  final Function(Barcode) onDetect;
  final Function() onExpired;
  final Function()? onCameraFeedReady;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CodeScannerCubit codeScannerCubit;
  final Function(int seconds) secondsLeftToExpire;
  @visibleForTesting
  bool get isUnitTesting => Platform.environment.containsKey('FLUTTER_TEST');

  const CodeScannerWidget({
    super.key,
    required this.onDetect,
    required this.onExpired,
    this.onCameraFeedReady,
    this.onCameraLensDirectionChanged,
    required this.codeScannerCubit,
    required this.secondsLeftToExpire,
  });

  @override
  State<CodeScannerWidget> createState() => _CodeScannerWidgetState();
}

class _CodeScannerWidgetState extends State<CodeScannerWidget> {
  CodeScannerCubit get _codeScannerCubit => widget.codeScannerCubit;
  late int _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _codeScannerCubit.setOnDetect(widget.onDetect);
    _codeScannerCubit.limitTimeInSeconds.addListener(initalizeProcessCountDown);
    initalizeProcessCountDown();
  }

  @override
  void dispose() {
    _codeScannerCubit.updateCanProcess(value: false);
    _timer?.cancel();
    _codeScannerCubit.getBarcodeScanner().close();
    _codeScannerCubit.limitTimeInSeconds
        .removeListener(initalizeProcessCountDown);
    super.dispose();
  }

  void initalizeProcessCountDown() {
    _currentTime = _codeScannerCubit.limitTimeInSeconds.value;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      widget.secondsLeftToExpire(_currentTime);
      if (_currentTime <= 0) {
        timer.cancel();
        widget.onExpired();
      } else {
        _currentTime = _currentTime - 1;
        _codeScannerCubit.updateCanProcess(value: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isUnitTesting
        ? const Text('Camera preview')
        : CodeCameraWidget(
            onImage: _codeScannerCubit.processImage,
            onCameraFeedReady: widget.onCameraFeedReady,
            onCameraLensDirectionChanged: widget.onCameraLensDirectionChanged,
            codeScannerCubit: _codeScannerCubit,
          );
  }
}
