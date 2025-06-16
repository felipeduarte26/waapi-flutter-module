import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:camera_platform_interface/src/types/camera_image_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/code_scanner/cubit/code_scanner_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/code_scanner/cubit/code_scanner_state.dart';

class CameraControllerMock extends Mock implements CameraController {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

List<CameraDescription> listCameras = [
  const CameraDescription(
    name: 'camera-1',
    lensDirection: CameraLensDirection.front,
    sensorOrientation: 180,
  ),
  const CameraDescription(
    name: 'camera-2',
    lensDirection: CameraLensDirection.back,
    sensorOrientation: 180,
  ),
];

class MockCameraValue extends Mock implements CameraValue {}

class MockBarcodeScanner extends Mock implements BarcodeScanner {}

class FakeInputImage extends Fake implements InputImage {}

class FakeBarcode extends Fake implements Barcode {
  @override
  String? displayValue = '';
}

void main() {
  late ISharedPreferencesService sharedPreferencesService;
  late CodeScannerCubit codeScannerCubit;
  late CameraController cameraController;
  late CameraValue cameraValue;
  late BarcodeScanner barcodeScanner;

  setUp(() {
    sharedPreferencesService = MockSharedPreferencesService();
    cameraController = CameraControllerMock();
    cameraValue = MockCameraValue();
    barcodeScanner = MockBarcodeScanner();

    when(
      () => cameraValue.isInitialized,
    ).thenReturn(false);

    when(
      () => cameraController.value,
    ).thenReturn(cameraValue);

    when(
      () => cameraValue.deviceOrientation,
    ).thenReturn(DeviceOrientation.landscapeLeft);

    codeScannerCubit = CodeScannerCubit(
      sharedPreferencesService: sharedPreferencesService,
      targetPlatform: TargetPlatform.iOS,
      barcodeScanner: barcodeScanner,
    );

    codeScannerCubit.listCameras = listCameras;
    codeScannerCubit.cameraController = cameraController;
    codeScannerCubit.cameraIndex = 1;
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    codeScannerCubit.setOnDetect((p0) => {});
    codeScannerCubit.updateCanProcess(value: false);
  });

  group('CodeScannerCubit', () {
    test('inputImageFromCameraImage should return InputImage type', () {
      final result = codeScannerCubit.inputImageFromCameraImage(
        CameraImage.fromPlatformInterface(
          CameraImageData(
            format: const CameraImageFormat(
              ImageFormatGroup.bgra8888,
              raw: 1111970369,
            ),
            planes: [
              CameraImagePlane(
                bytes: Uint8List.fromList([100, 200, 300]),
                bytesPerRow: 32,
              ),
            ],
            height: 1080,
            width: 1920,
          ),
        ),
      );
      expect(result, isNotNull);
      expect(result, isA<InputImage>());
      debugDefaultTargetPlatformOverride = null;
    });

    test(
        'inputImageFromCameraImage should return null when camera instance is null',
        () {
      codeScannerCubit = CodeScannerCubit(
        sharedPreferencesService: sharedPreferencesService,
        targetPlatform: TargetPlatform.android,
        barcodeScanner: barcodeScanner,
      );

      codeScannerCubit.listCameras = listCameras;
      codeScannerCubit.cameraController = cameraController;
      codeScannerCubit.cameraIndex = 1;

      final result = codeScannerCubit.inputImageFromCameraImage(
        CameraImage.fromPlatformInterface(
          CameraImageData(
            format: const CameraImageFormat(
              ImageFormatGroup.bgra8888,
              raw: 1111970369,
            ),
            planes: [
              CameraImagePlane(
                bytes: Uint8List.fromList([100, 200, 300]),
                bytesPerRow: 32,
              ),
            ],
            height: 1080,
            width: 1920,
          ),
        ),
      );
      expect(result, isNull);
    });

    test('stopLiveFeed should call all camera disposes', () async {
      final CameraController cameraController = CameraControllerMock();
      when(
        () => cameraController.stopImageStream(),
      ).thenAnswer((_) => Future.value());
      when(
        () => cameraController.dispose(),
      ).thenAnswer((_) => Future.value());
      codeScannerCubit.cameraController = cameraController;
      await codeScannerCubit.stopLiveFeed();
      verify(() => cameraController.stopImageStream()).called(1);
      verify(() => cameraController.dispose()).called(1);
      expect(codeScannerCubit.cameraController, isNull);
    });

    test('camera not ready test', () async {
      expect(codeScannerCubit.cameraReady(), false);
    });

    test('change of time test', () async {
      await codeScannerCubit.changeLimitTimeInSeconds(newTime: 10);
      expect(codeScannerCubit.limitTimeInSeconds.value, 10);
    });

    test('turn on flash test', () async {
      final CameraController cameraController = CameraControllerMock();
      codeScannerCubit.cameraController = cameraController;
      codeScannerCubit.flashMode = FlashMode.off;

      when(
        () => cameraController.setFlashMode(FlashMode.torch),
      ).thenAnswer(
        (_) async => {},
      );

      await codeScannerCubit.changeFlash();

      verify(
        () => cameraController.setFlashMode(FlashMode.torch),
      );
    });

    test('turn off flash test', () async {
      final CameraController cameraController = CameraControllerMock();
      codeScannerCubit.cameraController = cameraController;
      codeScannerCubit.flashMode = FlashMode.torch;

      when(
        () => cameraController.setFlashMode(FlashMode.off),
      ).thenAnswer(
        (_) async => {},
      );

      await codeScannerCubit.changeFlash();

      verify(
        () => cameraController.setFlashMode(FlashMode.off),
      );
    });

    blocTest<CodeScannerCubit, CodeScannerState>(
      'change camera test',
      setUp: () {
        codeScannerCubit.cameraIndex = 0;

        codeScannerCubit.cameraController = cameraController;

        when(
          () => cameraController.stopImageStream(),
        ).thenAnswer((_) async => {});

        when(
          () => cameraController.dispose(),
        ).thenAnswer((_) async => {});

        when(
          () => sharedPreferencesService.setCodeScannerCamera(value: 1),
        ).thenAnswer((_) async => {});

        when(
          () => sharedPreferencesService.getCodeScannerCamera(),
        ).thenAnswer((_) async => 1);
      },
      build: () => codeScannerCubit,
      act: (bloc) => bloc.changeCamera(),
      expect: () => [
        isA<ChangeCameraCodeScannerState>(),
        isA<ReadyCodeScannerState>(),
      ],
      verify: (bloc) {
        verify(() => cameraController.stopImageStream());
        verify(() => cameraController.dispose());
        verify(() => sharedPreferencesService.setCodeScannerCamera(value: 1));
        verify(() => sharedPreferencesService.getCodeScannerCamera());
      },
    );

    blocTest<CodeScannerCubit, CodeScannerState>(
      'initilize frontal camera test',
      setUp: () {
        codeScannerCubit.cameraIndex = 0;
        codeScannerCubit.cameraController = cameraController;

        when(
          () => sharedPreferencesService.getCodeScannerCamera(),
        ).thenAnswer((_) async => 1);
      },
      build: () => codeScannerCubit,
      act: (bloc) => bloc.initialize(),
      expect: () => [
        isA<ReadyCodeScannerState>(),
      ],
      verify: (bloc) {
        verify(() => sharedPreferencesService.getCodeScannerCamera());
      },
    );

    blocTest<CodeScannerCubit, CodeScannerState>(
      'initializes with wrong default camera test',
      setUp: () {
        codeScannerCubit.cameraIndex = 3;
        codeScannerCubit.cameraController = cameraController;

        when(
          () => sharedPreferencesService.getCodeScannerCamera(),
        ).thenAnswer((_) async => 3);

        when(
          () => sharedPreferencesService.setCodeScannerCamera(value: 0),
        ).thenAnswer((_) async => {});
      },
      build: () => codeScannerCubit,
      act: (bloc) => bloc.initialize(),
      expect: () => [
        isA<ReadyCodeScannerState>(),
      ],
      verify: (bloc) {
        verify(() => sharedPreferencesService.getCodeScannerCamera());
        verify(
          () => sharedPreferencesService.setCodeScannerCamera(value: 0),
        );
      },
    );

    test('processes reader image test', () async {
      Barcode barcode = FakeBarcode();
      registerFallbackValue(FakeInputImage());
      when(
        () => barcodeScanner.processImage(any()),
      ).thenAnswer((_) async => [barcode]);
      codeScannerCubit.updateCanProcess(value: true);

      await codeScannerCubit.processImage(FakeInputImage());
      verify(
        () => barcodeScanner.processImage(any()),
      );
    });
  });
}
