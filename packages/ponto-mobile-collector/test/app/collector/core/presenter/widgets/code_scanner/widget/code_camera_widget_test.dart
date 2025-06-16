import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/code_scanner/cubit/code_scanner_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/code_scanner/cubit/code_scanner_state.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/code_scanner/widget/code_camera_widget.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class FakeCameraImage extends Mock implements CameraImage {}

class FakeCameraDescription extends Fake implements CameraDescription {}

class FakeCameraController extends Fake implements CameraController {
  @override
  Future<bool> initialize() async {
    return true;
  }

  @override
  Future<void> startImageStream(void Function(CameraImage) onAvailable) async {}
}

class CodeScannerCubitMock extends Mock implements CodeScannerCubit {
  @override
  List<CameraDescription> listCameras = [FakeCameraDescription()];

  @override
  final CameraController cameraController = FakeCameraController();

  @override
  int cameraIndex = 0;
}

void main() {
  late CodeScannerCubit codeScannerCubit;
  late StreamController<CodeScannerState> stateStreamController;

  setUp(() {
    codeScannerCubit = CodeScannerCubitMock();
    stateStreamController = StreamController<CodeScannerState>();

    when(
      () => codeScannerCubit.state,
    ).thenReturn(InitCodeScannerState());

    when(
      () => codeScannerCubit.stream,
    ).thenAnswer((_) => stateStreamController.stream);

    when(
      () => codeScannerCubit.cameraReady(),
    ).thenReturn(true);

    when(
      () => codeScannerCubit.initialize(),
    ).thenAnswer((_) async => {});

    when(
      () => codeScannerCubit.stopLiveFeed(),
    ).thenAnswer((_) async => {});

    when(() => codeScannerCubit.stopLiveFeed()).thenAnswer((_) async => {});
  });

  Widget getCodeScannerWidget() {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: const Locale('pt'),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: CodeCameraWidget(
              onImage: (InputImage inputImage) {},
              codeScannerCubit: codeScannerCubit,
            ),
          ),
        ),
      ),
    );
  }

  group('CodeScannerWidget', () {
    testWidgets('camera not ready test', (widgetTester) async {
      when(
        () => codeScannerCubit.cameraReady(),
      ).thenReturn(false);

      final result = getCodeScannerWidget();
      await widgetTester.pumpWidget(result);
      expect(
        find.byKey(const Key('PlaceholderCameraPreview')),
        findsOneWidget,
      );

      verify(
        () => codeScannerCubit.initialize(),
      );
    });

    testWidgets('camera ready test', (widgetTester) async {
      final result = getCodeScannerWidget();
      await widgetTester.pumpWidget(result);
      expect(
        find.text('Camera Preview'),
        findsOneWidget,
      );

      verify(
        () => codeScannerCubit.initialize(),
      );
    });

    testWidgets('start camera test', (widgetTester) async {
      whenListen(
        codeScannerCubit,
        Stream.fromIterable([
          ReadyCodeScannerState(),
        ]),
      );

      final result = getCodeScannerWidget();
      await widgetTester.pumpWidget(result);

      expect(
        find.text('Camera Preview'),
        findsOneWidget,
      );

      expect(codeScannerCubit.state, isA<ReadyCodeScannerState>());

      verify(
        () => codeScannerCubit.initialize(),
      );
    });
  });
}
