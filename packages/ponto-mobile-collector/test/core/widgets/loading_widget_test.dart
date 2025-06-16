import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

Widget getWidget(String locale, Widget widget) {
  return MaterialApp(
    home: Localizations(
      delegates: CollectorLocalizations.localizationsDelegates,
      locale: Locale(locale),
      child: SeniorDesignSystem(
        theme: SENIOR_LIGHT_THEME,
        child: widget,
      ),
    ),
  );
}

void main() {
  testWidgets(
    'test Loading Screen',
    (WidgetTester tester) async {
      Widget widget = const LoadingWidget(
        color: SeniorColors.primaryColor,
        bottomLabel: 'Carregando...',
      );

      await tester.pumpWidget(getWidget('pt', widget));

      expect(find.text('Carregando...'), findsOneWidget);

      var circularProgressIndicatorFinder =
          find.byType(CircularProgressIndicator);
      expect(circularProgressIndicatorFinder, findsOneWidget);
    },
  );
}
