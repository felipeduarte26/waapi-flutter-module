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
    'StatusActionCardWidget Locale pt',
    () {
      const locale = Locale('pt');
      final collectorLocalizations = lookupCollectorLocalizations(locale);

      testWidgets(
        'Driving status action card when status is not "Driving"',
        (tester) async {
          final widget = getWidget(
            StatusActionCardWidget(
              driversJourneyEvent: StartDrivingEvent(),
              actionType: DriversWorkStatusActionEnum.driving,
              onPressed: (driversJourneyEvent) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startDrivingWithLineBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.truck,
            ),
            findsOneWidget,
          );

          final buttonFinder = find.byType(GestureDetector);
          final button = tester.widget<GestureDetector>(
            buttonFinder,
          );
          expect(
            button.onTap != null,
            isTrue,
          );
        },
      );

      testWidgets(
        'Driving status action card when status is "Driving"',
        (tester) async {
          final widget = getWidget(
            StatusActionCardWidget(
              driversJourneyEvent: StartDrivingEvent(),
              actionType: DriversWorkStatusActionEnum.driving,
              onPressed: (driversJourneyEvent) {},
              disabled: true,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startDrivingWithLineBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.truck,
            ),
            findsOneWidget,
          );

          final buttonFinder = find.byType(GestureDetector);
          final button = tester.widget<GestureDetector>(
            buttonFinder,
          );
          expect(
            button.onTap == null,
            isTrue,
          );
        },
      );

      testWidgets(
        'Mandatory break status action card when status is not "Mandatory break"',
        (tester) async {
          final widget = getWidget(
            StatusActionCardWidget(
              driversJourneyEvent: StartMandatoryBreakEvent(),
              actionType: DriversWorkStatusActionEnum.mandatoryBreak,
              onPressed: (driversJourneyEvent) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startMandatoryBreakWithLineBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidCirclePause,
            ),
            findsOneWidget,
          );

          final buttonFinder = find.byType(GestureDetector);
          final button = tester.widget<GestureDetector>(
            buttonFinder,
          );
          expect(
            button.onTap != null,
            isTrue,
          );
        },
      );

      testWidgets(
        'Mandatory break status action card when status is "Mandatory break"',
        (tester) async {
          final widget = getWidget(
            StatusActionCardWidget(
              driversJourneyEvent: StartMandatoryBreakEvent(),
              actionType: DriversWorkStatusActionEnum.mandatoryBreak,
              onPressed: (driversJourneyEvent) {},
              disabled: true,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startMandatoryBreakWithLineBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidCirclePause,
            ),
            findsOneWidget,
          );

          final buttonFinder = find.byType(GestureDetector);
          final button = tester.widget<GestureDetector>(
            buttonFinder,
          );
          expect(
            button.onTap == null,
            isTrue,
          );
        },
      );

      testWidgets(
        'Waiting status action card when status is not "Waiting"',
        (tester) async {
          final widget = getWidget(
            StatusActionCardWidget(
              driversJourneyEvent: StartWaitingBreakEvent(),
              actionType: DriversWorkStatusActionEnum.waiting,
              onPressed: (driversJourneyEvent) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startWaitingWithLineBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidHand,
            ),
            findsOneWidget,
          );

          final buttonFinder = find.byType(GestureDetector);
          final button = tester.widget<GestureDetector>(
            buttonFinder,
          );
          expect(
            button.onTap != null,
            isTrue,
          );
        },
      );

      testWidgets(
        'Waiting status action card when status is "Waiting"',
        (tester) async {
          final widget = getWidget(
            StatusActionCardWidget(
              driversJourneyEvent: StartWaitingBreakEvent(),
              actionType: DriversWorkStatusActionEnum.waiting,
              onPressed: (driversJourneyEvent) {},
              disabled: true,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startWaitingWithLineBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidHand,
            ),
            findsOneWidget,
          );

          final buttonFinder = find.byType(GestureDetector);
          final button = tester.widget<GestureDetector>(
            buttonFinder,
          );
          expect(
            button.onTap == null,
            isTrue,
          );
        },
      );

      testWidgets(
        'Food time status action card when status is not "Food time"',
        (tester) async {
          final widget = getWidget(
            StatusActionCardWidget(
              driversJourneyEvent: StartLunchEvent(),
              actionType: DriversWorkStatusActionEnum.foodTime,
              onPressed: (driversJourneyEvent) {},
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startFoodTimeWithLineBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.utensils,
            ),
            findsOneWidget,
          );

          final buttonFinder = find.byType(GestureDetector);
          final button = tester.widget<GestureDetector>(
            buttonFinder,
          );
          expect(
            button.onTap != null,
            isTrue,
          );
        },
      );

      testWidgets(
        'Food time status action card when status is "Food time"',
        (tester) async {
          final widget = getWidget(
            StatusActionCardWidget(
              driversJourneyEvent: StartLunchEvent(),
              actionType: DriversWorkStatusActionEnum.foodTime,
              onPressed: (driversJourneyEvent) {},
              disabled: true,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.startFoodTimeWithLineBreak,
            ),
            findsOneWidget,
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.utensils,
            ),
            findsOneWidget,
          );

          final buttonFinder = find.byType(GestureDetector);
          final button = tester.widget<GestureDetector>(
            buttonFinder,
          );
          expect(
            button.onTap == null,
            isTrue,
          );
        },
      );
    },
  );
}
