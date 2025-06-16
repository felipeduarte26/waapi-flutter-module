import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/widgets/face_registration_instructions.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/components/senior_button/senior_button_widget.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

void main() {
  Widget getWidget(String locale, [Function? startReconnaissanceCall]) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          locale: const Locale('pt'),
          delegates: CollectorLocalizations.localizationsDelegates,
          child: InstructionsScreen(
            startReconnaissanceCall: startReconnaissanceCall,
          ),
        ),
      ),
    );
  }

  group('Facial Recognition Instruction Screen', () {
    testWidgets('pop test', (tester) async {
      Widget widget = getWidget('pt');
      await tester.pumpWidget(widget);

      Finder iconFinder = find.byIcon(FontAwesomeIcons.angleLeft);
      expect(iconFinder, findsOneWidget);
      await tester.tap(iconFinder);
      await tester.pumpAndSettle();

      expect(find.byIcon(FontAwesomeIcons.angleLeft), findsNothing);
    });

    testWidgets(
      'should show InstructionsScreen in portuguese',
      (tester) async {
        final widget = getWidget('pt');

        await tester.pumpWidget(widget);

        final appBarTitleFinder = find.text(
          'Dicas para o reconhecimento facial',
        );
        final titleFinder = find.text(
          'Siga as instruções para uma boa captura',
        );
        final faceRegistrationInstructionsFinder =
            find.byType(FaceRegistrationInstructions);

        final buttonFinder = find.widgetWithText(
          SeniorButton,
          'Iniciar reconhecimento',
        );

        expect(appBarTitleFinder, findsOneWidget);
        expect(titleFinder, findsOneWidget);
        expect(faceRegistrationInstructionsFinder, findsOneWidget);
        expect(buttonFinder, findsOneWidget);
      },
    );

    testWidgets(
      'should call facial recognition test',
      (tester) async {
        bool startReconnaissanceIsCalled = false;
        final widget =
            getWidget('en', () => {startReconnaissanceIsCalled = true});

        await tester.pumpWidget(widget);

        final buttonStartReconnaissanceCall = find.text(
          'Iniciar reconhecimento',
        );

        await tester.tap(buttonStartReconnaissanceCall);

        expect(startReconnaissanceIsCalled, true);
        expect(buttonStartReconnaissanceCall, findsOneWidget);
      },
    );
  });
}
