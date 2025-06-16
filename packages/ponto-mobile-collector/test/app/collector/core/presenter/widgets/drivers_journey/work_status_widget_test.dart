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
    'WorkStatusWidget Locale pt',
    () {
      const locale = Locale('pt');
      final collectorLocalizations = lookupCollectorLocalizations(locale);

      testWidgets(
        '''Driver's work status to "Not started"''',
        (tester) async {
          final widget = getWidget(
            WorkStatusWidget(
              driversWorkStatus: DriversWorkStatusEnum.notStarted,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.notStarted,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidClock,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status to "Working"''',
        (tester) async {
          final widget = getWidget(
            WorkStatusWidget(
              driversWorkStatus: DriversWorkStatusEnum.working,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.working,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.businessTime,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status to "Driving"''',
        (tester) async {
          final widget = getWidget(
            WorkStatusWidget(
              driversWorkStatus: DriversWorkStatusEnum.driving,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.driving,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.truck,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status to "Mandatory break"''',
        (tester) async {
          final widget = getWidget(
            WorkStatusWidget(
              driversWorkStatus: DriversWorkStatusEnum.mandatoryBreak,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.mandatoryBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidCirclePause,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status to "Food time"''',
        (tester) async {
          final widget = getWidget(
            WorkStatusWidget(
              driversWorkStatus: DriversWorkStatusEnum.foodTime,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.foodTime,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.utensils,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status to "Waiting"''',
        (tester) async {
          final widget = getWidget(
            WorkStatusWidget(
              driversWorkStatus: DriversWorkStatusEnum.waiting,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.waiting,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidHand,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );
}
