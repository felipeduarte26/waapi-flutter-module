import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/widgets/face_registration_instructions.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

void main() {
  Widget getWidget(String locale) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: const FaceRegistrationInstructions(),
          ),
        ),
      ),
    );
  }

  group(
    'FaceRegistrationInstructions widget',
    () {
      testWidgets('should show widgets in portuguese', (tester) async {
        final widget = getWidget('pt');

        await tester.pumpWidget(widget);

        final circleAvatarFinder = find.byType(CircleAvatar);
        final eyeIconFinder = find.byIcon(FontAwesomeIcons.solidEye);
        final positionCellPhoneFinder = find.text(
          'Posicione o celular na altura dos seus olhos e olhe diretamente para a câmera;',
        );
        final sunIconFinder = find.byIcon(FontAwesomeIcons.solidSun);
        final beBrightEnvironmentFinder = find.text(
          'Esteja em um ambiente iluminado, sem pessoas e objetos ao fundo;',
        );
        final glassesIconFinder = find.byIcon(FontAwesomeIcons.glasses);
        final avoidWearingGlassesFinder = find.text(
          'Evite usar acessórios que escondam seu rosto, como óculos, bonés, máscaras e chapéus;',
        );
        final mobileIconFinder = find.byIcon(FontAwesomeIcons.mobileScreen);
        final avoidShakingYourCellPhoneFinder = find.text(
          'Evite tremer o seu celular durante a captura;',
        );
        final faceIconFinder = find.byIcon(FontAwesomeIcons.solidFaceTired);
        final avoidMakingFacesOrExpressionsFinder = find.text(
          'Evite fazer caretas ou expressões que possam interferir na qualidade da captura;',
        );
        final lightIconFinder = find.byIcon(FontAwesomeIcons.solidLightbulb);
        final ifNecessaryAskHelpCameraFinder = find.text(
          'Se achar necessário, peça ajuda a outra pessoa e ative a câmera traseira do seu celular.',
        );

        expect(circleAvatarFinder, findsNWidgets(6));
        expect(eyeIconFinder, findsOneWidget);
        expect(positionCellPhoneFinder, findsOneWidget);
        expect(sunIconFinder, findsOneWidget);
        expect(beBrightEnvironmentFinder, findsOneWidget);
        expect(glassesIconFinder, findsOneWidget);
        expect(avoidWearingGlassesFinder, findsOneWidget);
        expect(mobileIconFinder, findsOneWidget);
        expect(avoidShakingYourCellPhoneFinder, findsOneWidget);
        expect(faceIconFinder, findsOneWidget);
        expect(avoidMakingFacesOrExpressionsFinder, findsOneWidget);
        expect(lightIconFinder, findsOneWidget);
        expect(ifNecessaryAskHelpCameraFinder, findsOneWidget);
      });

      testWidgets('should show widgets in english', (tester) async {
        final widget = getWidget('en');

        await tester.pumpWidget(widget);

        final circleAvatarFinder = find.byType(CircleAvatar);
        final eyeIconFinder = find.byIcon(FontAwesomeIcons.solidEye);
        final positionCellPhoneFinder = find.text(
          'Position your cell phone at eye level and look directly to the camera;',
        );
        final sunIconFinder = find.byIcon(FontAwesomeIcons.solidSun);
        final beBrightEnvironmentFinder = find.text(
          'Stay in a well-lit environment, without people and objects in the background;',
        );
        final glassesIconFinder = find.byIcon(FontAwesomeIcons.glasses);
        final avoidWearingGlassesFinder = find.text(
          'Avoid using accessories that hide your face, such as glasses, caps, masks and hats;',
        );
        final mobileIconFinder = find.byIcon(FontAwesomeIcons.mobileScreen);
        final avoidShakingYourCellPhoneFinder = find.text(
          'Avoid shaking your cell phone during the capture;',
        );
        final faceIconFinder = find.byIcon(FontAwesomeIcons.solidFaceTired);
        final avoidMakingFacesOrExpressionsFinder = find.text(
          'Avoid making expressions that may interfere in the quality of the capture;',
        );
        final lightIconFinder = find.byIcon(FontAwesomeIcons.solidLightbulb);
        final ifNecessaryAskHelpCameraFinder = find.text(
          'If necessary, ask another person for help and activate the back camera of your cell phone.',
        );

        expect(circleAvatarFinder, findsNWidgets(6));
        expect(eyeIconFinder, findsOneWidget);
        expect(positionCellPhoneFinder, findsOneWidget);
        expect(sunIconFinder, findsOneWidget);
        expect(beBrightEnvironmentFinder, findsOneWidget);
        expect(glassesIconFinder, findsOneWidget);
        expect(avoidWearingGlassesFinder, findsOneWidget);
        expect(mobileIconFinder, findsOneWidget);
        expect(avoidShakingYourCellPhoneFinder, findsOneWidget);
        expect(faceIconFinder, findsOneWidget);
        expect(avoidMakingFacesOrExpressionsFinder, findsOneWidget);
        expect(lightIconFinder, findsOneWidget);
        expect(ifNecessaryAskHelpCameraFinder, findsOneWidget);
      });

      testWidgets('should show widgets in spanish', (tester) async {
        final widget = getWidget('es');

        await tester.pumpWidget(widget);

        final circleAvatarFinder = find.byType(CircleAvatar);
        final eyeIconFinder = find.byIcon(FontAwesomeIcons.solidEye);
        final positionCellPhoneFinder = find.text(
          'Coloque el teléfono celular a la altura de los ojos y mire directamente a la cámara;',
        );
        final sunIconFinder = find.byIcon(FontAwesomeIcons.solidSun);
        final beBrightEnvironmentFinder = find.text(
          'Sitúese en un entorno bien iluminado, sin personas ni objetos de fondo;',
        );
        final glassesIconFinder = find.byIcon(FontAwesomeIcons.glasses);
        final avoidWearingGlassesFinder = find.text(
          'Evite llevar accesorios que oculten su rostro, como gafas, gorras, máscaras y sombreros;',
        );
        final mobileIconFinder = find.byIcon(FontAwesomeIcons.mobileScreen);
        final avoidShakingYourCellPhoneFinder = find.text(
          'Evite agitar el teléfono celular durante la captura;',
        );
        final faceIconFinder = find.byIcon(FontAwesomeIcons.solidFaceTired);
        final avoidMakingFacesOrExpressionsFinder = find.text(
          'Evite hacer muecas o expresiones que puedan interferir en la calidad de la captura;',
        );
        final lightIconFinder = find.byIcon(FontAwesomeIcons.solidLightbulb);
        final ifNecessaryAskHelpCameraFinder = find.text(
          'Si es necesario, pida ayuda a otra persona y active la cámara trasera de su celular.',
        );

        expect(circleAvatarFinder, findsNWidgets(6));
        expect(eyeIconFinder, findsOneWidget);
        expect(positionCellPhoneFinder, findsOneWidget);
        expect(sunIconFinder, findsOneWidget);
        expect(beBrightEnvironmentFinder, findsOneWidget);
        expect(glassesIconFinder, findsOneWidget);
        expect(avoidWearingGlassesFinder, findsOneWidget);
        expect(mobileIconFinder, findsOneWidget);
        expect(avoidShakingYourCellPhoneFinder, findsOneWidget);
        expect(faceIconFinder, findsOneWidget);
        expect(avoidMakingFacesOrExpressionsFinder, findsOneWidget);
        expect(lightIconFinder, findsOneWidget);
        expect(ifNecessaryAskHelpCameraFinder, findsOneWidget);
      });
    },
  );
}
