import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/collector_camera/collector_camera_widget.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockCollectorCameraCubit
    extends MockBloc<CollectorCameraCubit, CollectorCameraState>
    implements CollectorCameraCubit {}

class MockCameraController extends Mock implements CameraController {}

class MockXFile extends Mock implements XFile {}

class FakeCameraDescription extends Fake implements CameraDescription {}

void main() {
  String tImagePreviewText = 'Image Preview';
  Widget tImagePreview = Text(tImagePreviewText);
  late CollectorCameraWidget collectorCameraWidget;
  late CollectorCameraCubit collectorCameraCubit;
  late CameraController cameraController;
  late CameraDescription cameraDescription;
  late XFile xFile;

  setUp(() {
    collectorCameraCubit = MockCollectorCameraCubit();
    cameraDescription = FakeCameraDescription();
    cameraController = MockCameraController();
    collectorCameraWidget = CollectorCameraWidget(
      cameraCubit: collectorCameraCubit,
      availableCamerasTest: () => [cameraDescription],
      cameraControllerTest: cameraController,
      imagePreviewTest: tImagePreview,
    );

    when(() => collectorCameraCubit.initializingCamera())
        .thenAnswer((_) async => {});

    when(() => collectorCameraCubit.state).thenReturn(InitializingCamera());

    when(() => collectorCameraCubit.closeCamera()).thenAnswer((_) async => {});

    when(() => cameraController.dispose()).thenAnswer((_) async => {});

    when(() => collectorCameraCubit.camera).thenReturn(0);

    when(() => collectorCameraCubit.flash).thenReturn(false);

    when(() => collectorCameraCubit.readyCamera(camera: any(named: 'camera')))
        .thenAnswer((_) async => {});

    when(() => cameraController.setFlashMode(FlashMode.off))
        .thenAnswer((_) async => ());

    when(() => cameraController.setFlashMode(FlashMode.torch))
        .thenAnswer((_) async => ());

    when(() => cameraController.initialize()).thenAnswer((_) async => {});
  });

  Widget getWidget(Widget widget) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: const Locale('pt'),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: widget,
          ),
        ),
      ),
    );
  }

  group('CollectorCameraWidget', () {
    testWidgets('Should preloading content test', (tester) async {
      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());
      final widget = getWidget(collectorCameraWidget);
      await tester.pumpWidget(widget);
      expect(find.byKey(const Key('widget_preview_loading')), findsOneWidget);
    });

    testWidgets('Should show camera content test', (tester) async {
      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());
      final widget = getWidget(collectorCameraWidget);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(find.text(tImagePreviewText), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('Should change the flash to on test', (tester) async {
      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());
      whenListen(
        collectorCameraCubit,
        Stream.fromIterable([LightOn()]),
      );
      final widget = getWidget(collectorCameraWidget);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      verify(() => cameraController.setFlashMode(FlashMode.torch)).called(1);
    });

    testWidgets('Should change the flash to off test', (tester) async {
      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());
      whenListen(
        collectorCameraCubit,
        Stream.fromIterable([LightOff()]),
      );
      final widget = getWidget(collectorCameraWidget);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      verify(() => cameraController.setFlashMode(FlashMode.off)).called(1);
    });

    testWidgets('Should change the camera test', (tester) async {
      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());
      when(() => collectorCameraCubit.setCamera(0)).thenAnswer((_) async => {});
      when(() => collectorCameraCubit.camera).thenReturn(1);

      whenListen(
        collectorCameraCubit,
        Stream.fromIterable([ChangingCamera()]),
      );
      final widget = getWidget(collectorCameraWidget);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      verify(() => collectorCameraCubit.setCamera(0)).called(1);
      verify(() => collectorCameraCubit.camera).called(2);
    });

    testWidgets('Should capture an image test', (tester) async {
      xFile = MockXFile();
      when(() => collectorCameraCubit.state).thenReturn(ReadyCamera());
      when(() => cameraController.takePicture()).thenAnswer((_) async => xFile);
      when(() => collectorCameraCubit.capturedImage(xFile))
          .thenAnswer((_) async => {});

      whenListen(
        collectorCameraCubit,
        Stream.fromIterable([CapturingImage()]),
      );

      final widget = getWidget(collectorCameraWidget);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      verify(() => cameraController.takePicture()).called(1);
      verify(() => collectorCameraCubit.capturedImage(xFile)).called(1);
    });
  });
}
