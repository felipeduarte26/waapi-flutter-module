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
    'JourneyInfoWidget Locale pt',
    () {
      const locale = Locale('pt');
      final collectorLocalizations = lookupCollectorLocalizations(locale);

      testWidgets(
        'Test Journey Info',
        (tester) async {
          final widget = getWidget(
            JourneyInfoWidget(
              title: collectorLocalizations.journeyStart,
              content: 'content',
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.journeyStart,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              'content',
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.circleInfo,
            ),
            findsNothing,
          );
        },
      );

      testWidgets(
        'Test Journey Info with "prefixContent"',
        (tester) async {
          final widget = getWidget(
            JourneyInfoWidget(
              title: collectorLocalizations.journeyStart,
              prefixContent: 'prefixContent',
              content: 'content',
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.journeyStart,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              'prefixContent',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              'content',
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.circleInfo,
            ),
            findsNothing,
          );
        },
      );

      testWidgets(
        'Test Journey Info with "onInfoButtonPressed"',
        (tester) async {
          final widget = getWidget(
            JourneyInfoWidget(
              title: collectorLocalizations.journeyStart,
              prefixContent: 'prefixContent',
              content: 'content',
              onInfoButtonPressed: () {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.journeyStart,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              'content',
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.circleInfo,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Test Journey Info with "prefixContent" and "onInfoButtonPressed"',
        (tester) async {
          final widget = getWidget(
            JourneyInfoWidget(
              title: collectorLocalizations.journeyStart,
              prefixContent: 'prefixContent',
              content: 'content',
              onInfoButtonPressed: () {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.journeyStart,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              'prefixContent',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              'content',
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.circleInfo,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );
}
