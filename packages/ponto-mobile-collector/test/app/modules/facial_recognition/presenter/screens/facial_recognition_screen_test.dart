import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_gryfo_lib/fragment_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_settings_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_recognition/facial_recognition_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_recognition/facial_recognition_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/facial_recognition_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

class MockRegisterClockingEventBloc extends Mock
    implements RegisterClockingEventBloc {}

class MockFaceRecognitionSettingsService extends Mock
    implements FaceRecognitionSettingsService {}

class MockFacialRecognitionCubit
    extends MockBloc<FacialRecognitionCubit, FacialRecognitionState>
    implements FacialRecognitionCubit {}

void main() {
  String tFacialRecognitionScreen = 'tFacialRecognitionScreen';
  FragmentContainer fragmentContainer = FragmentContainer();
  late FlutterGryfoLib flutterGryfoLib;
  late FacialRecognitionCubit facialRecognitionCubit;
  late FaceRecognitionSettingsService faceRecognitionSettingsService;

  setUp(() {
    registerFallbackValue(fragmentContainer);

    flutterGryfoLib = MockFlutterGryfoLib();
    facialRecognitionCubit = MockFacialRecognitionCubit();
    faceRecognitionSettingsService = MockFaceRecognitionSettingsService();

    when(
      () => flutterGryfoLib.createFragmentContainer(
        backgroundColor: SeniorColors.grayscale90,
        hideDefaultOverlay: true,
      ),
    ).thenReturn(fragmentContainer);

    when(
      () => facialRecognitionCubit.getMessage(),
    ).thenReturn('');

    when(
      () => facialRecognitionCubit.changeCameraDefault(),
    ).thenAnswer((_) async => {});

    when(
      () => flutterGryfoLib.closeRecognize(),
    ).thenAnswer((_) async => true);

    when(
      () => flutterGryfoLib.toggleLight(),
    ).thenAnswer((_) async => true);

    when(
      () => flutterGryfoLib.switchCam(),
    ).thenAnswer((_) async => true);

    when(
      () => flutterGryfoLib.createFragmentContainer(
        backgroundColor: Colors.black,
        hideDefaultOverlay: true,
      ),
    ).thenReturn(fragmentContainer);

    when(
      () => facialRecognitionCubit.openRecognize(),
    ).thenAnswer((_) async => {'success': true});

    when(
      () => facialRecognitionCubit.state,
    ).thenReturn(RecognitionInitializationInProgress());

    when(
      () => facialRecognitionCubit.finalize(),
    ).thenAnswer(
      (_) async => {},
    );

    when(
      () => facialRecognitionCubit.openRecognize(),
    ).thenAnswer(
      (_) async => {},
    );

    when(() => facialRecognitionCubit.selectedCamera).thenReturn(0);
    when(() => facialRecognitionCubit.timerDuration).thenReturn(0);

    when(
      () => faceRecognitionSettingsService.setSettings(),
    ).thenAnswer((_) async => true);
  });

  Widget getWidget(Widget widget) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        routes: {
          '/${FacialRecognitionRoutes.registrationFull}': (context) =>
              Text(tFacialRecognitionScreen),
        },
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: const Locale('pt'),
          child: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }

  group('FacialRecognitionScreen', () {
    testWidgets('show successfully test', (tester) async {
      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(CameraOverlayWidget), findsOneWidget);
      expect(find.text('fragment'), findsOneWidget);
      expect(find.text('Reconhecimento facial'), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.xmark), findsOneWidget);

      verify(() => facialRecognitionCubit.getMessage()).called(1);
      verify(() => facialRecognitionCubit.openRecognize()).called(1);
    });

    testWidgets('show RecognitionSuccess test', (tester) async {
      whenListen(
        facialRecognitionCubit,
        Stream.fromIterable([
          RecognitionSuccess(),
        ]),
      );

      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      verify(() => facialRecognitionCubit.getMessage()).called(1);
      verify(() => facialRecognitionCubit.openRecognize()).called(1);
    });

    testWidgets('show messages RecognitionSuccess test', (tester) async {
      when(
        () => facialRecognitionCubit.state,
      ).thenReturn(RecognitionSuccess());

      whenListen(
        facialRecognitionCubit,
        Stream.fromIterable([
          RecognitionSuccess(),
        ]),
      );

      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      final overlayFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is CameraOverlayWidget &&
            widget.uiState == CameraOverlayState.success,
      );

      expect(overlayFinder, findsOneWidget);
    });

    testWidgets('show messages NewMessageFailure test', (tester) async {
      when(
        () => facialRecognitionCubit.state,
      ).thenReturn(NewMessageFailure());

      whenListen(
        facialRecognitionCubit,
        Stream.fromIterable([
          ChangeCameraInProgress(),
          ChangeCameraSuccess(),
          NewMessageFailure(),
        ]),
      );

      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      final overlayFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is CameraOverlayWidget &&
            widget.uiState == CameraOverlayState.error,
      );

      expect(overlayFinder, findsOneWidget);
    });

    testWidgets('call close button test', (tester) async {
      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(FontAwesomeIcons.xmark));

      verify(() => facialRecognitionCubit.getMessage()).called(1);
      verify(() => facialRecognitionCubit.openRecognize()).called(1);
    });

    testWidgets('call close button and back to face recognition screen test',
        (tester) async {
      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(FontAwesomeIcons.xmark));
      await tester.pump();
      await tester.tap(find.text('Voltar'));
      await tester.pump();

      expect(find.text('fragment'), findsOneWidget);
      verifyNever(() => facialRecognitionCubit.finalize());
    });

    testWidgets('call close button and back to home screen test',
        (tester) async {
      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(FontAwesomeIcons.xmark));
      await tester.pump();
      await tester.tap(find.text('Registrar sem face'));

      verify(
        () => facialRecognitionCubit.finalize(),
      ).called(1);
    });

    testWidgets('call toggle light button test', (tester) async {
      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(FontAwesomeIcons.boltLightning));

      verify(() => flutterGryfoLib.toggleLight()).called(1);
    });

    testWidgets('call change camera button test', (tester) async {
      final widget = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(FontAwesomeIcons.cameraRotate));

      verify(() => facialRecognitionCubit.changeCameraDefault()).called(1);
    });

    testWidgets('should set alertFraud to false when state is FraudEvidenceOff',
        (tester) async {
      whenListen(
        facialRecognitionCubit,
        Stream.fromIterable([
          FraudEvidenceOff(),
        ]),
      );

      when(
        () => facialRecognitionCubit.finalize(),
      ).thenAnswer((_) async => {});

      final widgetTeste = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widgetTeste);
      await tester.pump(Durations.short4);

      final screenState = tester.state<FacialRecognitionScreenState>(
        find.byType(FacialRecognitionScreen),
      );
      expect(screenState.alertFraud, isFalse);
    });

    testWidgets(
        'should set alertFraud to true when state is FraudEvidenceStart',
        (tester) async {
      whenListen(
        facialRecognitionCubit,
        Stream.fromIterable([
          FraudEvidenceStart(),
        ]),
      );

      when(
        () => facialRecognitionCubit.finalize(),
      ).thenAnswer((_) async => {});

      final widgetTeste = getWidget(
        FacialRecognitionScreen(
          delay: 0,
          facialRecognitionCubit: facialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const SizedBox(
            width: 300,
            height: 600,
            child: Text('fragment'),
          ),
        ),
      );

      await tester.pumpWidget(widgetTeste);
      await tester.pump(Durations.short4);

      final screenState = tester.state<FacialRecognitionScreenState>(
        find.byType(FacialRecognitionScreen),
      );
      expect(screenState.alertFraud, isTrue);
    });
  });
}
