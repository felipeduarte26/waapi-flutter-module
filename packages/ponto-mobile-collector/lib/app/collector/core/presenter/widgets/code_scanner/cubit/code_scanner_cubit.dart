// ignore_for_file: unnecessary_this, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import '../../../../domain/services/shared_preferences/ishared_preferences_service.dart';
import 'code_scanner_state.dart';

class CodeScannerCubit extends Cubit<CodeScannerState> {
  final ISharedPreferencesService _sharedPreferencesService;
  final BarcodeScanner _barcodeScanner;
  final ValueNotifier<int> limitTimeInSeconds = ValueNotifier(60);
  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };
  final TargetPlatform _targetPlatform;
  late Function(Barcode) _onDetect;
  late final Function(InputImage inputImage) onImage;
  late final VoidCallback? onCameraFeedReady;
  late final Function(CameraLensDirection direction)?
      onCameraLensDirectionChanged;

  CameraController? cameraController;
  List<CameraDescription> listCameras = [];
  int cameraIndex = -1;
  CameraLensDirection camera = CameraLensDirection.front;
  bool changingCameraLens = false;
  FlashMode flashMode = FlashMode.off;
  bool enableFlash = false;
  bool _canProcess = false;

  CodeScannerCubit({
    required ISharedPreferencesService sharedPreferencesService,
    required TargetPlatform targetPlatform,
    required BarcodeScanner barcodeScanner,
  })  : _sharedPreferencesService = sharedPreferencesService,
        _targetPlatform = targetPlatform,
        _barcodeScanner = barcodeScanner,
        super(InitCodeScannerState());

  Future<int> loadCameraDefault() async {
    cameraIndex = await _sharedPreferencesService.getCodeScannerCamera();
    return cameraIndex;
  }

  InputImage? inputImageFromCameraImage(CameraImage image) {
    if (cameraController == null) return null;
    final camera = listCameras[cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (_targetPlatform == TargetPlatform.iOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    }
    if (_targetPlatform == TargetPlatform.android) {
      var rotationCompensation =
          _orientations[cameraController!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (_targetPlatform == TargetPlatform.android &&
            format != InputImageFormat.nv21) ||
        (_targetPlatform == TargetPlatform.iOS &&
            format != InputImageFormat.bgra8888)) return null;
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  Future<void> initialize() async {
    await loadCameraDefault();
    if (listCameras.isEmpty) {
      listCameras = await availableCameras();
    }

    if (listCameras.isNotEmpty) {
      if (listCameras.length <= cameraIndex) {
        cameraIndex = 0;
        await _sharedPreferencesService.setCodeScannerCamera(
          value: cameraIndex,
        );
      }

      enableFlash =
          listCameras[cameraIndex].lensDirection == CameraLensDirection.back;

      emit(ReadyCodeScannerState());
    }
  }

  Future<void> changeCamera() async {
    emit(ChangeCameraCodeScannerState());
    cameraIndex += 1;
    await stopLiveFeed();
    await _sharedPreferencesService.setCodeScannerCamera(value: cameraIndex);
    initialize();
  }

  Future<void> changeFlash() async {
    if (listCameras.length > cameraIndex &&
        listCameras[cameraIndex].lensDirection == CameraLensDirection.back) {
      if (flashMode == FlashMode.off) {
        flashMode = FlashMode.torch;
        cameraController?.setFlashMode(FlashMode.torch);
      } else {
        flashMode = FlashMode.off;
        cameraController?.setFlashMode(FlashMode.off);
      }
    }
  }

  Future<void> stopLiveFeed() async {
    await cameraController?.stopImageStream();
    await cameraController?.dispose();
    cameraController = null;
  }

  Future<void> changeLimitTimeInSeconds({required int newTime}) async {
    limitTimeInSeconds.value = newTime;
    limitTimeInSeconds.notifyListeners();
  }

  bool cameraReady() {
    return !(listCameras.isEmpty ||
        cameraController == null ||
        cameraController?.value.isInitialized == false);
  }

  BarcodeScanner getBarcodeScanner() {
    return _barcodeScanner;
  }

  void setOnDetect(Function(Barcode) onDetect) {
    _onDetect = onDetect;
  }

  void updateCanProcess({required bool value}) {
    _canProcess = value;
  }

  Future<void> processImage(InputImage inputImage) async {
    if (_canProcess == false) return;
    updateCanProcess(value: false);
    final barcodes = await _barcodeScanner.processImage(inputImage);
    if (barcodes.isNotEmpty) {
      for (final barcode in barcodes) {
        if (barcode.displayValue != null) {
          _onDetect(barcode);
        }
      }
    }
  }
}
