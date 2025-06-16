import 'dart:developer';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import '../../../../domain/services/shared_preferences/ishared_preferences_service.dart';
import 'collector_camera_state.dart';

class CollectorCameraCubit extends Cubit<CollectorCameraState> {
  final ISharedPreferencesService _sharedPreferencesService;

  bool openCamera = false;
  int camera = 0;
  bool flash = false;
  List<int>? image;
  XFile? imageFile;
  String? employeeId;

  CollectorCameraCubit({
    required ISharedPreferencesService sharedPreferencesService,
  })  : _sharedPreferencesService = sharedPreferencesService,
        super(ClosedCamera());

  Future<void> initializingCamera() async {
    emit(InitializingCamera());
    camera = await _sharedPreferencesService.getCameraDefault();
  }

  Future<bool> changeLight({bool? light}) async {
    if (light != null) {
      flash = light;
    } else {
      flash = !flash;
    }

    flash ? emit(LightOn()) : emit(LightOff());

    return flash;
  }

  Future<void> readyCamera({required int camera}) async {
    _sharedPreferencesService.setCameraDefault(value: camera);
    emit(ReadyCamera());
  }

  Future<void> changeCamera() async {
    flash = false;
    emit(ChangingCamera());
  }

  Future<void> setCamera(int camera) async {
    this.camera = camera;
    _sharedPreferencesService.setCameraDefault(value: camera);
    emit(CameraChanged());
  }

  Future<void> captureImage() async {
    emit(CapturingImage());
  }

  Future<void> capturedImage(XFile newImage) async {
    imageFile = newImage;
    image = await _checkAndResizeImage(newImage);
    emit(CapturedImage());
  }

  Future<void> closeCamera() async {
    emit(ClosedCamera());
  }

  Future<List<int>> _checkAndResizeImage(XFile imageFile) async {
    Uint8List bytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(bytes);

    const int maxWidth = 480;
    const int maxHeight = 720;
    img.Image resizedImage;

    if (image != null) {
      log('CollectorCameraCubit: Original resolution: ${image.width}x${image.height}');
      if (image.width > maxWidth || image.height > maxHeight) {
        if (image.width / image.height > maxWidth / maxHeight) {
          resizedImage = img.copyResize(image, width: maxWidth);
        } else {
          resizedImage = img.copyResize(image, height: maxHeight);
        }
        log('CollectorCameraCubit: Resized resolution: ${resizedImage.width}x${resizedImage.height}');
        return img.encodeJpg(resizedImage);
      } else {
        return bytes;
      }
    } else {
      return [];
    }
  }
}
