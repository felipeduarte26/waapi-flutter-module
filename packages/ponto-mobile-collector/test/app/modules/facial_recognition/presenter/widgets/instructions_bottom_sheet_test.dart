import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/widgets/face_registration_instructions.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/widgets/instructions_bottom_sheet.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

void main() {
  String tFacialRecognitionScreen = 'tFacialRecognitionScreen';

  Widget getWidget(Widget widget) {
    return MaterialApp(
      routes: {
        '/${FacialRecognitionRoutes.registrationFull}': (context) =>
            Text(tFacialRecognitionScreen),
      },
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

  group('FaceRegistrationScreen', () {
    testWidgets('show loading check information test', (tester) async {
      final widget = getWidget(
        const InstructionsBottonSheet(),
      );

      await tester.pumpWidget(widget);
      expect(find.byType(FaceRegistrationInstructions), findsOneWidget);
    });
  });
}
