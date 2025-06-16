import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/widgets/instruction_item.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

void main() {
  Widget getWidget(String locale, IconData icon, String text) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: InstructionItem(
              icon: icon,
              content: text,
            ),
          ),
        ),
      ),
    );
  }

  group(
    'Instruction Item widget',
    () {
      testWidgets('should show InstructionItem with icon and text',
          (tester) async {
        final widget = getWidget(
          'pt',
          FontAwesomeIcons.solidEye,
          'Posicione o celular na altura dos seus olhos e olhe diretamente para a câmera;',
        );

        await tester.pumpWidget(widget);

        final circleAvatarFinder = find.byType(CircleAvatar);
        final iconFinder = find.byIcon(FontAwesomeIcons.solidEye);
        final textFinder = find.text(
          'Posicione o celular na altura dos seus olhos e olhe diretamente para a câmera;',
        );

        expect(circleAvatarFinder, findsOneWidget);
        expect(iconFinder, findsOneWidget);
        expect(textFinder, findsOneWidget);
      });
    },
  );
}
