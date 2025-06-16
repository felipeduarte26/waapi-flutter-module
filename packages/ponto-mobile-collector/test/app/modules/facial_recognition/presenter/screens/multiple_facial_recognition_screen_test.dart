import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_gryfo_lib/fragment_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_settings_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_recognition/multiple/multiple_facial_recognition_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_recognition/multiple/multiple_facial_recognition_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/multiple_facial_recognition_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

import '../../../../../mocks/clocking_event_mock.dart';
import '../../../clocking_event/presenter/widgets/clocking_event_widget_test.dart';

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

class MockRegisterClockingEventBloc
    extends MockBloc<RegisterClockingEventEvent, RegisterClockingState>
    implements RegisterClockingEventBloc {}

class MockMultipleFacialRecognitionCubit extends MockBloc<
    MultipleFacialRecognitionCubit,
    MultipleFacialRecognitionState> implements MultipleFacialRecognitionCubit {}

class MockWorkIndicatorCubit extends Mock implements WorkIndicatorCubit {}

class MockIShowBottomSheetUsecase extends Mock
    implements IShowBottomSheetUsecase {}

class MockConfirmationSnackbarWidget extends Mock
    implements ConfirmationSnackbarWidget {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockFaceRecognitionSettingsService extends Mock
    implements FaceRecognitionSettingsService {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  DateTime day = DateTime(2023, 4, 27, 10, 15, 33);
  String tMultipleFacialRecognitionScreen = 'tMultipleFacialRecognitionScreen';
  final TimerClockState timerState = TimerClockState(
    dateTime: DateTime.parse('2024-05-02 10:30:00'),
  );
  FragmentContainer fragmentContainer = FragmentContainer();
  late FlutterGryfoLib flutterGryfoLib;
  late MultipleFacialRecognitionCubit multipleFacialRecognitionCubit;
  late WorkIndicatorCubit workIndicatorCubit;
  late IShowBottomSheetUsecase showBottomSheetUsecase;
  late ConfirmationSnackbarWidget confirmationSnackbarWidget;
  late BuildContext context;
  late TimerBloc timerBloc;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late FaceRecognitionSettingsService faceRecognitionSettingsService;

  final Map<String, String> messages = {
    'facialRegistrationCompleted': 'facialRegistrationCompleted',
    'facialCaceledRegistration': 'facialCaceledRegistration',
    'facialRegistering': 'facialRegistering',
    'facialCollaboratorNotFound': 'facialCollaboratorNotFound',
  };

  setUp(() {
    registerFallbackValue(fragmentContainer);

    flutterGryfoLib = MockFlutterGryfoLib();
    multipleFacialRecognitionCubit = MockMultipleFacialRecognitionCubit();
    workIndicatorCubit = MockWorkIndicatorCubit();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    showBottomSheetUsecase = MockShowBottomSheetUsecase();
    confirmationSnackbarWidget = MockConfirmationSnackbarWidget();
    faceRecognitionSettingsService = MockFaceRecognitionSettingsService();
    context = FakeBuildContext();
    timerBloc = MockTimerBloc();

    registerFallbackValue(context);

    when(() => multipleFacialRecognitionCubit.finalize())
        .thenAnswer((_) async => {});

    when(
      () => multipleFacialRecognitionCubit.changeCameraDefault(),
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
        backgroundColor: SeniorColors.grayscale90,
        hideDefaultOverlay: true,
      ),
    ).thenReturn(fragmentContainer);

    when(
      () => flutterGryfoLib.openRecognize(useDefaultMessages: false),
    ).thenAnswer((_) async => {'success': true});

    when(
      () => multipleFacialRecognitionCubit.openRecognize(
        messages: messages,
      ),
    ).thenAnswer((_) async => {});

    when(
      () => multipleFacialRecognitionCubit.state,
    ).thenReturn(MultiModeRecognitionIsStarting());

    when(
      () => registerClockingEventBloc.state,
    ).thenReturn(SuccessRegisterState(clockingEvent: clockingEventMock));

    when(() => multipleFacialRecognitionCubit.selectedCamera).thenReturn(0);

    when(() => workIndicatorCubit.state).thenReturn(WorkIndicatorUpdate());

    when(() => workIndicatorCubit.isWorkInProgress).thenReturn(false);

    when(() => workIndicatorCubit.stream).thenAnswer(
      (_) => StreamController<WorkIndicatorState>().stream,
    );

    when(
      () => confirmationSnackbarWidget.show(
        clockingEvent: clockingEventMock,
        hideActionButton: true,
      ),
    ).thenAnswer((_) async => {});

    when(() => timerBloc.lastDateTime).thenReturn(timerState.dateTime);
    when(() => timerBloc.stream)
        .thenAnswer((_) => Stream.fromIterable([timerState]));
    when(() => timerBloc.state).thenReturn(TimerClockState(dateTime: day));
    when(() => multipleFacialRecognitionCubit.timerDuration).thenReturn(0);

    when(() => faceRecognitionSettingsService.setSettings())
        .thenAnswer((_) async => true);
  });

  Widget getWidget(Widget widget) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        routes: {
          '/${FacialRecognitionRoutes.multipleRecognitionFull}': (context) =>
              Text(tMultipleFacialRecognitionScreen),
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
    testWidgets('show successfully test: MultiModeRecognitionInProgress',
        (tester) async {
      whenListen(
        registerClockingEventBloc,
        Stream.fromIterable([
          RegistrationCanceledState(),
        ]),
      );

      final widget = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pump(Durations.short4);

      expect(find.byType(CameraOverlayWidget), findsOneWidget);
      expect(find.text('fragment'), findsOneWidget);
      expect(find.text('Registrar por rosto'), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.angleLeft), findsOneWidget);
    });

    testWidgets('show successfully test: MultiModeRecognitionSuccess',
        (tester) async {
      whenListen(
        registerClockingEventBloc,
        Stream.fromIterable([
          SuccessRegisterState(clockingEvent: clockingEventMock),
        ]),
      );
      whenListen(
        multipleFacialRecognitionCubit,
        Stream.fromIterable([
          MultiModeRecognitionSuccess(),
        ]),
      );

      final widget = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pump(Durations.short4);

      expect(find.byType(CameraOverlayWidget), findsOneWidget);
      expect(find.text('fragment'), findsOneWidget);
      expect(find.text('Registrar por rosto'), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.angleLeft), findsOneWidget);
    });

    testWidgets('show successfully test: MultiModeChangeCameraInProgress',
        (tester) async {
      whenListen(
        registerClockingEventBloc,
        Stream.fromIterable([
          RegistrationCanceledState(),
        ]),
      );

      when(
        () => flutterGryfoLib.toggleLight(),
      ).thenAnswer((_) async => false);

      when(() => multipleFacialRecognitionCubit.selectedCamera).thenReturn(
        1,
      );

      final widget = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pump(Durations.short4);

      expect(find.byType(CameraOverlayWidget), findsOneWidget);
      expect(find.text('fragment'), findsOneWidget);
      expect(find.text('Registrar por rosto'), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.angleLeft), findsOneWidget);
    });

    testWidgets('loading screen test', (tester) async {
      final collectorLocalizations =
          lookupCollectorLocalizations(const Locale('pt'));

      final widget = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pump(Durations.short4);

      expect(
        find.text(collectorLocalizations.loading),
        findsOneWidget,
      );
    });

    testWidgets('test pop', (tester) async {
      whenListen(
        multipleFacialRecognitionCubit,
        Stream.fromIterable([
          MultiModeRecognitionReady(),
        ]),
      );

      final widget = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pump(Durations.short4);

      await tester.tap(find.byKey(const Key('closeMultipleFacialRecognition')));
      verify(() => multipleFacialRecognitionCubit.finalize()).called(1);
    });

    testWidgets('test back button', (widgetTester) async {
      whenListen(
        multipleFacialRecognitionCubit,
        Stream.fromIterable([
          MultiModeRecognitionReady(),
        ]),
      );

      final widget = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await widgetTester.pumpWidget(widget);
      await widgetTester.pump();
      await widgetTester.pump(Durations.short4);
      await widgetTester.pump();

      await widgetTester.binding.handlePopRoute();
      verify(() => multipleFacialRecognitionCubit.finalize()).called(1);
    });

    testWidgets('onTap onToggleFlash CameraOverlayWidget', (tester) async {
      whenListen(
        multipleFacialRecognitionCubit,
        Stream.fromIterable([
          MultiModeRecognitionReady(),
        ]),
      );

      when(
        () => flutterGryfoLib.toggleLight(),
      ).thenAnswer((_) async => false);

      when(() => multipleFacialRecognitionCubit.selectedCamera).thenReturn(1);

      final widget = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pump(Durations.short4);

      expect(find.byIcon(FontAwesomeIcons.boltLightning), findsOneWidget);

      await tester.tap(find.byIcon(FontAwesomeIcons.boltLightning));

      verify(() => flutterGryfoLib.toggleLight()).called(1);
    });

    testWidgets('onTap onToggleCamera CameraOverlayWidget', (tester) async {
      whenListen(
        multipleFacialRecognitionCubit,
        Stream.fromIterable([
          MultiModeRecognitionReady(),
        ]),
      );

      when(
        () => multipleFacialRecognitionCubit.changeCameraDefault(),
      ).thenAnswer((_) async => {});

      when(() => multipleFacialRecognitionCubit.selectedCamera).thenReturn(1);

      final widget = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pump(Durations.short4);

      expect(find.byIcon(FontAwesomeIcons.cameraRotate), findsOneWidget);

      await tester.tap(find.byIcon(FontAwesomeIcons.cameraRotate));

      verify(
        () => multipleFacialRecognitionCubit.changeCameraDefault(),
      ).called(1);
    });

    testWidgets('onTap onPopInvoked', (tester) async {
      whenListen(
        multipleFacialRecognitionCubit,
        Stream.fromIterable([
          MultiModeRecognitionReady(),
        ]),
      );

      when(
        () => multipleFacialRecognitionCubit.finalize(),
      ).thenAnswer((_) async => {});

      final widgetTeste = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widgetTeste);
      await tester.pump(Durations.short4);

      final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
      await widgetsAppState.didPopRoute();

      verify(
        () => multipleFacialRecognitionCubit.finalize(),
      ).called(1);
    });

    testWidgets(
        'should set alertFraud to false when state is MultiModeFraudEvidenceOff',
        (tester) async {
      whenListen(
        multipleFacialRecognitionCubit,
        Stream.fromIterable([
          MultiModeFraudEvidenceOff(),
        ]),
      );

      when(
        () => multipleFacialRecognitionCubit.finalize(),
      ).thenAnswer((_) async => {});

      final widgetTeste = getWidget(
        MultipleFacialRecognitionScreen(
          multipleFacialRecognitionCubit: multipleFacialRecognitionCubit,
          flutterGryfoLib: flutterGryfoLib,
          registerClockingEventBloc: registerClockingEventBloc,
          timerBloc: timerBloc,
          confirmationSnackbarWidget: confirmationSnackbarWidget,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
          faceRecognitionSettingsService: faceRecognitionSettingsService,
          fragmentTest: const Text('fragment'),
        ),
      );

      await tester.pumpWidget(widgetTeste);
      await tester.pump(Durations.short4);

      final screenState = tester.state<MultipleFacialRecognitionScreenState>(
        find.byType(MultipleFacialRecognitionScreen),
      );
      expect(screenState.alertFraud, isFalse);
    });
  });
}
