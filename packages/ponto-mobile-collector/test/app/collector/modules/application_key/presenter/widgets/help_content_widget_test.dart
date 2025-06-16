import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/widgets/help_content_widget.dart';
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
    'HelpContentWidget',
    () {
      testWidgets(
        'Show widget successfully test',
        (tester) async {
          Widget widget = getWidget(
            const HelpContentWidget(
              applicationKeyHelpContent1: 'applicationKeyHelpContent1',
              applicationKeyHelpContent2: 'applicationKeyHelpContent2',
              applicationKeyHelpContent3: 'applicationKeyHelpContent3',
              applicationKeyHelpTitle: 'applicationKeyHelpTitle',
              helpTextDocumentationPortal: 'helpTextDocumentationPortal',
            ),
            'pt',
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              'applicationKeyHelpContent1 helpTextDocumentationPortal',
            ),
            findsOneWidget,
          );
          expect(find.text('applicationKeyHelpContent2'), findsOneWidget);
          expect(find.text('applicationKeyHelpContent3'), findsOneWidget);
          expect(find.text('applicationKeyHelpTitle'), findsOneWidget);
          expect(find.text('helpTextDocumentationPortal'), findsOneWidget);
        },
      );
    },
  );
}
