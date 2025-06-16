// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

void main() {
  bool onTapCalled = false;
  Widget getWidget(Widget widget) {
    return MaterialApp(
      home: SeniorDesignSystem(
        theme: SENIOR_LIGHT_THEME,
        child: Scaffold(body: widget),
      ),
    );
  }

  testWidgets(
    'ConfigurationRowWidget show widget test',
    (tester) async {
      Widget widget = getWidget(
        ConfigurationRowWidget(
          description: 'Minha Descrição',
          icon: const Icon(
            FontAwesomeIcons.desktop,
            size: SeniorIconSize.large - SeniorIconSize.xsmall,
            color: SeniorColors.neutralColor600,
          ),
          title: 'Titulo',
          onTap: () {},
        ),
      );

      await tester.pumpWidget(widget);

      final iconDesktopFinder = find.byIcon(FontAwesomeIcons.desktop);
      final descriptionFinder = find.text('Minha Descrição');
      final titleFinder = find.text('Titulo');

      expect(iconDesktopFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
    },
  );

  testWidgets('ConfigurationRowWidget should call onTap when tapped',
      (tester) async {
      Widget widget = getWidget(
        ConfigurationRowWidget(
          description: 'Minha Descrição',
          icon: const Icon(
            FontAwesomeIcons.desktop,
            size: SeniorIconSize.large - SeniorIconSize.xsmall,
            color: SeniorColors.neutralColor600,
          ),
          title: 'Titulo',
            onTap: () {
          onTapCalled = true;
        },
        ),
      );
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(ConfigurationRowWidget));
    await tester.pump();
    expect(onTapCalled, isTrue);
  });
}
