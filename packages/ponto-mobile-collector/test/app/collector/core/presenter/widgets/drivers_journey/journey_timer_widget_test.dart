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
    'JourneyTimerWidget Locale pt',
    () {
      const locale = Locale('pt');
      final collectorLocalizations = lookupCollectorLocalizations(locale);

      testWidgets(
        '''Driver's journey time when "Working"''',
        (tester) async {
          final (
            hours,
            minutes,
            seconds,
          ) = (
            2,
            5,
            30,
          );
          final timer = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds,
          );
          final (
            hoursFormatted,
            minutesFormatted,
            secondsFormatted,
          ) = (
            hours.toString().padLeft(2, '0'),
            minutes.toString().padLeft(2, '0'),
            seconds.toString().padLeft(2, '0'),
          );

          final widget = getWidget(
            JourneyTimerWidget(
              driversWorkStatus: DriversWorkStatusEnum.working,
              timer: timer,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.timeInWorking,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$hoursFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$minutesFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              secondsFormatted,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.hours,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.minutes,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.seconds,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's journey time when "Driving"''',
        (tester) async {
          final (
            hours,
            minutes,
            seconds,
          ) = (
            2,
            5,
            30,
          );
          final timer = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds,
          );
          final (
            hoursFormatted,
            minutesFormatted,
            secondsFormatted,
          ) = (
            hours.toString().padLeft(2, '0'),
            minutes.toString().padLeft(2, '0'),
            seconds.toString().padLeft(2, '0'),
          );

          final widget = getWidget(
            JourneyTimerWidget(
              driversWorkStatus: DriversWorkStatusEnum.driving,
              timer: timer,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.timeInDriving,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$hoursFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$minutesFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              secondsFormatted,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.hours,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.minutes,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.seconds,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's journey time when "Mandatory break"''',
        (tester) async {
          final (
            hours,
            minutes,
            seconds,
          ) = (
            2,
            5,
            30,
          );
          final timer = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds,
          );
          final (
            hoursFormatted,
            minutesFormatted,
            secondsFormatted,
          ) = (
            hours.toString().padLeft(2, '0'),
            minutes.toString().padLeft(2, '0'),
            seconds.toString().padLeft(2, '0'),
          );

          final widget = getWidget(
            JourneyTimerWidget(
              driversWorkStatus: DriversWorkStatusEnum.mandatoryBreak,
              timer: timer,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.timeInMandatoryBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$hoursFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$minutesFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              secondsFormatted,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.hours,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.minutes,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.seconds,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's journey time when "Food time"''',
        (tester) async {
          final (
            hours,
            minutes,
            seconds,
          ) = (
            2,
            5,
            30,
          );
          final timer = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds,
          );
          final (
            hoursFormatted,
            minutesFormatted,
            secondsFormatted,
          ) = (
            hours.toString().padLeft(2, '0'),
            minutes.toString().padLeft(2, '0'),
            seconds.toString().padLeft(2, '0'),
          );

          final widget = getWidget(
            JourneyTimerWidget(
              driversWorkStatus: DriversWorkStatusEnum.foodTime,
              timer: timer,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.timeInFoodTime,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$hoursFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$minutesFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              secondsFormatted,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.hours,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.minutes,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.seconds,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''Driver's journey time when "Waiting"''',
        (tester) async {
          final (
            hours,
            minutes,
            seconds,
          ) = (
            2,
            5,
            30,
          );
          final timer = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds,
          );
          final (
            hoursFormatted,
            minutesFormatted,
            secondsFormatted,
          ) = (
            hours.toString().padLeft(2, '0'),
            minutes.toString().padLeft(2, '0'),
            seconds.toString().padLeft(2, '0'),
          );

          final widget = getWidget(
            JourneyTimerWidget(
              driversWorkStatus: DriversWorkStatusEnum.waiting,
              timer: timer,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.timeInWaiting,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$hoursFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '$minutesFormatted:',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              secondsFormatted,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.hours,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.minutes,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.seconds,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );
}
