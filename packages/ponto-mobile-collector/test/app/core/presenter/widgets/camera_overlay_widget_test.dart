import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

Widget getWidget(String locale, Widget widget) {
  return MaterialApp(
    home: Localizations(
      delegates: CollectorLocalizations.localizationsDelegates,
      locale: Locale(locale),
      child: Scaffold(
        body: SeniorDesignSystem(
          theme: SENIOR_LIGHT_THEME,
          child: widget,
        ),
      ),
    ),
  );
}

void main() {
  group('CameraOverlay', () {
    testWidgets('Should show the initial state correctly', (tester) async {
      var widget = getWidget(
        'pt',
        const CameraOverlayWidget(
          uiState: CameraOverlayState.initial,
          cameraType: CameraType.facialRecognition,
          child: Column(),
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byIcon(FontAwesomeIcons.boltLightning), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.cameraRotate), findsOneWidget);
      expect(find.byType(Ink), findsOneWidget);
      expect(find.byType(ClipPath), findsNWidgets(2));
    });

    testWidgets('Should show the processing state correctly', (tester) async {
      var widget = getWidget(
        'pt',
        const CameraOverlayWidget(
          uiState: CameraOverlayState.processing,
          cameraType: CameraType.facialRecognition,
          child: Column(),
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('Should show the success state correctly', (tester) async {
      var widget = getWidget(
        'pt',
        const CameraOverlayWidget(
          uiState: CameraOverlayState.success,
          cameraType: CameraType.facialRecognition,
          child: Column(),
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byIcon(FontAwesomeIcons.solidCircleCheck), findsOneWidget);
    });

    testWidgets('Should show the message correctly', (tester) async {
      var widget = getWidget(
        'pt',
        const CameraOverlayWidget(
          customMessage: 'customMessage',
          cameraType: CameraType.facialRecognition,
          uiState: CameraOverlayState.initial,
          child: Column(),
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.text('customMessage'), findsOneWidget);
    });

    testWidgets('Should call function buttons correctly', (tester) async {
      bool onCaptureImageCall = false;
      bool onToggleCameraCall = false;
      bool onToggleFlashCall = false;

      var widget = getWidget(
        'pt',
        CameraOverlayWidget(
          onCaptureImage: () => onCaptureImageCall = true,
          onToggleCamera: () => onToggleCameraCall = true,
          onToggleFlash: () => onToggleFlashCall = true,
          uiState: CameraOverlayState.initial,
          cameraType: CameraType.facialRecognition,
          child: const Column(),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(FontAwesomeIcons.boltLightning));
      await tester.tap(find.byIcon(FontAwesomeIcons.cameraRotate));
      await tester.tap(find.byKey(const Key('cameraCaptureButtonKey')));

      expect(onCaptureImageCall, true);
      expect(onToggleCameraCall, true);
      expect(onToggleFlashCall, true);
    });

    testWidgets('should render recognitionBlocked and remainingTime correctly',
        (WidgetTester tester) async {
      const locale = Locale('pt');
      final collectorLocalizations = lookupCollectorLocalizations(locale);
      const int remainingTime = 30;

      var widget = getWidget(
        'pt',
        const CountdownTimerWidget(
          colorMessage: Colors.black,
          durationInSeconds: remainingTime,
        ),
      );

      await tester.pumpWidget(widget);
      expect(
        find.text('${collectorLocalizations.recognitionBlocked}:'),
        findsOneWidget,
      );
      expect(
        find.text('$remainingTime ${collectorLocalizations.secondsFullName}'),
        findsOneWidget,
      );
    });
  });
}
