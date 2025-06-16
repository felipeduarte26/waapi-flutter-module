import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

void main() {
  Widget getWidget(Widget child, String locale) {
    return MaterialApp(
      home: Localizations(
        delegates: const [
          CollectorLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale(locale),
        child: SeniorDesignSystem(
          theme: SENIOR_LIGHT_THEME,
          child: Scaffold(body: child),
        ),
      ),
    );
  }

  setUp(
    () {},
  );

  group(
    'PontoCardWidget',
    () {
      testWidgets(
        'Show widget successfully test',
        (tester) async {
          Widget widget = getWidget(
            const PontoStateCardWidget(
              disabled: false,
              message: 'message',
              iconData: FontAwesomeIcons.chevronRight,
            ),

            'pt',
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              'message',
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.chevronRight,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );
}
