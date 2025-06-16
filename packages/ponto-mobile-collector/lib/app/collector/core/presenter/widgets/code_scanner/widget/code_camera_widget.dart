import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import '../cubit/code_scanner_cubit.dart';
import '../cubit/code_scanner_state.dart';

class CodeCameraWidget extends StatefulWidget {
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CodeScannerCubit codeScannerCubit;
  @visibleForTesting
  bool get isUnitTesting => Platform.environment.containsKey('FLUTTER_TEST');

  const CodeCameraWidget({
    super.key,
    required this.onImage,
    this.onCameraFeedReady,
    this.onCameraLensDirectionChanged,
    required this.codeScannerCubit,
  });

  @override
  State<CodeCameraWidget> createState() => _CodeCameraWidgetState();
}

class _CodeCameraWidgetState extends State<CodeCameraWidget> {
  CodeScannerCubit get codeScannerCubit => widget.codeScannerCubit;

  @override
  void initState() {
    super.initState();
    widget.codeScannerCubit.initialize();
  }

  @override
  void dispose() {
    codeScannerCubit.stopLiveFeed();
    super.dispose();
  }

  Future _startLiveFeed() async {
    final camera = codeScannerCubit.listCameras[codeScannerCubit.cameraIndex];
    codeScannerCubit.cameraController = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: defaultTargetPlatform == TargetPlatform.android
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    codeScannerCubit.cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }

      codeScannerCubit.cameraController
          ?.startImageStream(_processCameraImage)
          .then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });

      setState(() {});
    });
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = codeScannerCubit.inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CodeScannerCubit, CodeScannerState>(
      bloc: codeScannerCubit,
      listener: (context, state) {
        if (state is ReadyCodeScannerState) {
          _startLiveFeed();
        }
      },
      builder: (context, state) {
        return Builder(
          builder: (context) {
            if (!codeScannerCubit.cameraReady()) {
              return Container(
                key: const Key('PlaceholderCameraPreview'),
                color: Colors.black,
              );
            }
            return Container(
              color: Colors.black,
              child: Center(
                child: state is ChangeCameraCodeScannerState
                    ? const Center(
                        child: Text(
                          '',
                          key: Key('ChangingCameraTextWidget'),
                        ),
                      )
                    : widget.isUnitTesting
                        ? const Text('Camera Preview')
                        : CameraPreview(codeScannerCubit.cameraController!),
              ),
            );
          },
        );
      },
    );
  }
}
