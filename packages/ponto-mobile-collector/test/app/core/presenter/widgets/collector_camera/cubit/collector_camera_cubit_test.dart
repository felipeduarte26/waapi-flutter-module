import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockXFile extends Mock implements XFile {}

void main() {
  late CollectorCameraCubit collectorCameraCubit;
  late ISharedPreferencesService sharedPreferencesService;
  late XFile xFile;

  setUp(() {
    sharedPreferencesService = MockSharedPreferencesService();
    xFile = MockXFile();
    when(() => xFile.readAsBytes()).thenAnswer(
      (invocation) async => Uint8List.fromList([0, 2, 5, 7]),
    );
    collectorCameraCubit = CollectorCameraCubit(
      sharedPreferencesService: sharedPreferencesService,
    );
  });

  group('CollectorCameraCubit', () {
    blocTest(
      'emits [InitializingCamera]'
      ' when initializingCamera is call test',
      setUp: () {
        when(
          () => sharedPreferencesService.getCameraDefault(),
        ).thenAnswer((_) async => 0);
      },
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.initializingCamera(),
      expect: () => [
        isA<InitializingCamera>(),
      ],
      verify: (bloc) {
        verify(() => sharedPreferencesService.getCameraDefault()).called(1);
        verifyNoMoreInteractions(sharedPreferencesService);
      },
    );

    blocTest(
      'emits [LightOn]'
      ' when changeLight is call test',
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.changeLight(light: true),
      expect: () => [
        isA<LightOn>(),
      ],
    );

    blocTest(
      'emits [LightOff]'
      ' when changeLight is call test',
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.changeLight(light: false),
      expect: () => [
        isA<LightOff>(),
      ],
    );

    blocTest(
      'emits [LightOn]'
      ' when changeLight is call and default value test',
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.changeLight(),
      expect: () => [
        isA<LightOn>(),
      ],
    );

    blocTest(
      'emits [ReadyCamera]'
      ' when readyCamera is call test',
      setUp: () {
        when(
          () => sharedPreferencesService.setCameraDefault(value: 0),
        ).thenAnswer((_) async => {});
      },
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.readyCamera(camera: 0),
      expect: () => [
        isA<ReadyCamera>(),
      ],
      verify: (bloc) {
        verify(
          () => sharedPreferencesService.setCameraDefault(value: 0),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesService);
      },
    );

    blocTest(
      'emits [ChangingCamera]'
      ' when changeCamera is call test',
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.changeCamera(),
      expect: () => [
        isA<ChangingCamera>(),
      ],
    );

    blocTest(
      'emits [CameraChanged]'
      ' when changeCamera is call test',
      setUp: () {
        when(
          () => sharedPreferencesService.setCameraDefault(value: 0),
        ).thenAnswer((_) async => {});
      },
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.setCamera(0),
      expect: () => [
        isA<CameraChanged>(),
      ],
      verify: (bloc) {
        verify(
          () => sharedPreferencesService.setCameraDefault(value: 0),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesService);
      },
    );

    blocTest(
      'emits [CapturingImage]'
      ' when changeCamera is call test',
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.captureImage(),
      expect: () => [
        isA<CapturingImage>(),
      ],
    );

    blocTest(
      'emits [CapturedImage]'
      ' when capturedImage is call test',
      setUp: () {
        final image = img.Image(width: 1000, height: 1000);
        when(() => xFile.readAsBytes()).thenAnswer(
          (invocation) async => image.toUint8List(),
        );
      },
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.capturedImage(xFile),
      expect: () => [
        isA<CapturedImage>(),
      ],
    );

    blocTest(
      'emits [ClosedCamera]'
      ' when closeCamera is call test',
      build: () => collectorCameraCubit,
      act: (cubit) async => await cubit.closeCamera(),
      expect: () => [
        isA<ClosedCamera>(),
      ],
    );
  });
}
