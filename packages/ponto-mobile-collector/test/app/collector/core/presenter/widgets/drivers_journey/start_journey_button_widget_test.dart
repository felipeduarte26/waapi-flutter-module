import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
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
    'StartJourneyButtonWidget Locale pt',
    () {
      const locale = Locale('pt');
      final collectorLocalizations = lookupCollectorLocalizations(locale);

      testWidgets(
        '''Driver's work status is "Not started"''',
        (tester) async {
          final widget = getWidget(
            JourneyButtonWidget(
              driversWorkStatus: DriversWorkStatusEnum.notStarted,
              eventToAdd: StartJourneyEvent(),
              onPressed: (_) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startJourney,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status is "Working"''',
        (tester) async {
          final widget = getWidget(
            JourneyButtonWidget(
              driversWorkStatus: DriversWorkStatusEnum.working,
              eventToAdd: EndJourneyEvent(),
              onPressed: (_) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.newJourney,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status is "Driving"''',
        (tester) async {
          final widget = getWidget(
            JourneyButtonWidget(
              driversWorkStatus: DriversWorkStatusEnum.driving,
              eventToAdd: StopDrivingEvent(),
              onPressed: (_) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.stopDriving,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status is "Mandatory break"''',
        (tester) async {
          final widget = getWidget(
            JourneyButtonWidget(
              driversWorkStatus: DriversWorkStatusEnum.mandatoryBreak,
              eventToAdd: EndMandatoryBreakEvent(),
              onPressed: (_) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.stopMandatoryBreak,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status is "Food time"''',
        (tester) async {
          final widget = getWidget(
            JourneyButtonWidget(
              driversWorkStatus: DriversWorkStatusEnum.foodTime,
              eventToAdd: EndLunchEvent(),
              onPressed: (_) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.stopFoodTime,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's work status is "Waiting"''',
        (tester) async {
          final widget = getWidget(
            JourneyButtonWidget(
              driversWorkStatus: DriversWorkStatusEnum.waiting,
              eventToAdd: EndWaitingBreakEvent(),
              onPressed: (_) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.stopWaiting,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );
}
