import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infra/utils/constants/constants_msg_log.dart';
import 'cubit/collector_camera_cubit.dart';
import 'cubit/collector_camera_state.dart';

class CollectorCameraWidget extends StatefulWidget {
  final CollectorCameraCubit _cameraCubit;

  /// Parameters to facilitate component testing, do not use in production
  final CameraController? _cameraControllerTest;
  final List<CameraDescription> Function()? _availableCamerasTest;
  final Widget? _imagePreviewTest;
  final bool _isMockForTest;

  const CollectorCameraWidget({
    required CollectorCameraCubit cameraCubit,
    CameraController? cameraControllerTest,
    List<CameraDescription> Function()? availableCamerasTest,
    Widget? imagePreviewTest,
    bool isMockForTest = false,
    super.key,
  })  : _cameraCubit = cameraCubit,
        _cameraControllerTest = cameraControllerTest,
        _availableCamerasTest = availableCamerasTest,
        _imagePreviewTest = imagePreviewTest,
        _isMockForTest = isMockForTest;

  @override
  CollectorCameraWidgetState createState() => CollectorCameraWidgetState();
}

class CollectorCameraWidgetState extends State<CollectorCameraWidget> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  Future<void>? _future;

  @override
  void initState() {
    super.initState();
    _future = initializeCamera();
  }

  @override
  void dispose() {
    if (!widget._isMockForTest) {
      _controller.dispose();
      widget._cameraCubit.closeCamera();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            key: Key('widget_preview_loading'),
          );
        } else {
          return BlocConsumer<CollectorCameraCubit, CollectorCameraState>(
            bloc: widget._cameraCubit,
            listener: (context, state) {
              if (state is LightOn) {
                _controller.setFlashMode(FlashMode.torch);
                log(ConstantsMsgLog.cameraLightOn);
              } else if (state is LightOff) {
                _controller.setFlashMode(FlashMode.off);
                log(ConstantsMsgLog.cameraLightoff);
              } else if (state is ChangingCamera) {
                changeCamera();
                log(ConstantsMsgLog.cameraSelectedChanged);
              } else if (state is CapturingImage) {
                capture();
                log(ConstantsMsgLog.cameraCapturingImage);
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: widget._imagePreviewTest ?? CameraPreview(_controller),
              );
            },
          );
        }
      },
    );
  }

  Future<void> initializeCamera() async {
    if (widget._isMockForTest) {
      return;
    }

    await widget._cameraCubit.initializingCamera();
    int numCamera = widget._cameraCubit.camera;

    _cameras = widget._availableCamerasTest?.call() ?? await availableCameras();

    if (_cameras.length <= numCamera) {
      numCamera = 0;
    }

    _controller = widget._cameraControllerTest ??
        CameraController(
          _cameras[numCamera],
          ResolutionPreset.max,
          enableAudio: false,
        );

    // widget._cameraCubit.flash
    //     ? _controller.setFlashMode(FlashMode.torch)
    //     : _controller.setFlashMode(FlashMode.off);

    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            log(ConstantsMsgLog.cameraAccessDenied);
            break;
          default:
            log(e.code);
            break;
        }
      }
    });

    widget._cameraCubit.readyCamera(camera: numCamera);
  }

  Future<void> changeCamera() async {
    _cameras = widget._availableCamerasTest?.call() ?? await availableCameras();
    int newCamera = widget._cameraCubit.camera + 1;

    if (newCamera >= 2) {
      newCamera = 0;
    }

    final CameraController newController;
    newController = widget._cameraControllerTest ??
        CameraController(
          _cameras[newCamera],
          ResolutionPreset.max,
          enableAudio: false,
        );

    try {
      await newController.initialize();
      _controller = newController;
    } catch (e) {
      _controller = _controller;
    }

    widget._cameraCubit.setCamera(newCamera);
  }

  Future<void> capture() async {
    final XFile image = await _controller.takePicture();
    await widget._cameraCubit.capturedImage(image);
    log(ConstantsMsgLog.cameraImageCaptured);
  }
}
