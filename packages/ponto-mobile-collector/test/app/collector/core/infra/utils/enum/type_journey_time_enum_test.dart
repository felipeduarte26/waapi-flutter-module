import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/type_journey_time_enum.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';

void main() {
  group(
    'TypeJourneyTimeEnum',
    () {
      group(
        'fromInt',
        () {
          test(
            'fromInt returns correct TypeJourneyTimeEnum for valid values',
            () {
              expect(
                TypeJourneyTimeEnum.fromInt(
                  clock.ClockingEventUseEnum.clockingEvent.codigo,
                ),
                TypeJourneyTimeEnum.clockingEvent,
              );
              expect(
                TypeJourneyTimeEnum.fromInt(
                  clock.ClockingEventUseEnum.paidBreak.codigo,
                ),
                TypeJourneyTimeEnum.paidBreak,
              );
              expect(
                TypeJourneyTimeEnum.fromInt(
                  clock.ClockingEventUseEnum.mandatoryBreak.codigo,
                ),
                TypeJourneyTimeEnum.mandatoryBreak,
              );
              expect(
                TypeJourneyTimeEnum.fromInt(
                  clock.ClockingEventUseEnum.driving.codigo,
                ),
                TypeJourneyTimeEnum.driving,
              );
              expect(
                TypeJourneyTimeEnum.fromInt(
                  clock.ClockingEventUseEnum.waiting.codigo,
                ),
                TypeJourneyTimeEnum.waiting,
              );
            },
          );

          test(
            'fromInt throws exception for invalid value',
            () {
              expect(() => TypeJourneyTimeEnum.fromInt(-1), throwsException);
            },
          );
        },
      );

      testWidgets(
        'status returns correct localized strings for TypeJourneyTimeEnum',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              localizationsDelegates: const [
                CollectorLocalizations.delegate,
              ],
              home: Container(),
            ),
          );

          final context = tester.element(find.byType(Container));
          final collectorLocalizations = CollectorLocalizations.of(context);

          expect(
            TypeJourneyTimeEnum.clockingEvent.status(context),
            collectorLocalizations.work,
          );
          expect(
            TypeJourneyTimeEnum.driving.status(context),
            collectorLocalizations.drive,
          );
          expect(
            TypeJourneyTimeEnum.mandatoryBreak.status(context),
            collectorLocalizations.mandatoryBreak,
          );
          expect(
            TypeJourneyTimeEnum.mealBreak.status(context),
            collectorLocalizations.foodTimeOrBreaks,
          );
          expect(
            TypeJourneyTimeEnum.waiting.status(context),
            collectorLocalizations.timeInWaiting,
          );
          expect(
            TypeJourneyTimeEnum.paidBreak.status(context),
            collectorLocalizations.paidBreak,
          );
          expect(
            TypeJourneyTimeEnum.working.status(context),
            collectorLocalizations.work,
          );
        },
      );

      testWidgets(
        'icon returns correct IconData for TypeJourneyTimeEnum',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              localizationsDelegates: const [
                CollectorLocalizations.delegate,
              ],
              home: Container(),
            ),
          );

          final context = tester.element(find.byType(Container));

          expect(
            TypeJourneyTimeEnum.clockingEvent.icon(context),
            FontAwesomeIcons.businessTime,
          );
          expect(
            TypeJourneyTimeEnum.driving.icon(context),
            FontAwesomeIcons.truck,
          );
          expect(
            TypeJourneyTimeEnum.mandatoryBreak.icon(context),
            FontAwesomeIcons.solidCirclePause,
          );
          expect(
            TypeJourneyTimeEnum.mealBreak.icon(context),
            FontAwesomeIcons.utensils,
          );
          expect(
            TypeJourneyTimeEnum.waiting.icon(context),
            FontAwesomeIcons.solidHand,
          );
          expect(
            TypeJourneyTimeEnum.paidBreak.icon(context),
            FontAwesomeIcons.solidCirclePause,
          );
          expect(
            TypeJourneyTimeEnum.working.icon(context),
            FontAwesomeIcons.businessTime,
          );
        },
      );
      group(
        'toInt',
        () {
          test(
            'toInt returns correct integer for valid TypeJourneyTimeEnum values',
            () {
              expect(
                TypeJourneyTimeEnum.toInt(TypeJourneyTimeEnum.clockingEvent),
                clock.ClockingEventUseEnum.clockingEvent.codigo,
              );
              expect(
                TypeJourneyTimeEnum.toInt(TypeJourneyTimeEnum.paidBreak),
                clock.ClockingEventUseEnum.paidBreak.codigo,
              );
              expect(
                TypeJourneyTimeEnum.toInt(TypeJourneyTimeEnum.waiting),
                clock.ClockingEventUseEnum.waiting.codigo,
              );
              expect(
                TypeJourneyTimeEnum.toInt(TypeJourneyTimeEnum.mandatoryBreak),
                clock.ClockingEventUseEnum.mandatoryBreak.codigo,
              );
              expect(
                TypeJourneyTimeEnum.toInt(TypeJourneyTimeEnum.driving),
                clock.ClockingEventUseEnum.driving.codigo,
              );
              expect(
                TypeJourneyTimeEnum.toInt(TypeJourneyTimeEnum.working),
                98,
              );
              expect(
                TypeJourneyTimeEnum.toInt(TypeJourneyTimeEnum.mealBreak),
                99,
              );
            },
          );
        },
      );
      group(
        'build',
        () {
          test(
            'build returns correct TypeJourneyTimeEnum for valid names',
            () {
              expect(
                TypeJourneyTimeEnum.build(
                  TypeJourneyTimeEnum.clockingEvent.name,
                ),
                TypeJourneyTimeEnum.clockingEvent,
              );
              expect(
                TypeJourneyTimeEnum.build(TypeJourneyTimeEnum.paidBreak.name),
                TypeJourneyTimeEnum.paidBreak,
              );
              expect(
                TypeJourneyTimeEnum.build(
                  TypeJourneyTimeEnum.mandatoryBreak.name,
                ),
                TypeJourneyTimeEnum.mandatoryBreak,
              );
              expect(
                TypeJourneyTimeEnum.build(TypeJourneyTimeEnum.driving.name),
                TypeJourneyTimeEnum.driving,
              );
              expect(
                TypeJourneyTimeEnum.build(TypeJourneyTimeEnum.waiting.name),
                TypeJourneyTimeEnum.waiting,
              );
              expect(
                TypeJourneyTimeEnum.build(TypeJourneyTimeEnum.mealBreak.name),
                TypeJourneyTimeEnum.mealBreak,
              );
              expect(
                TypeJourneyTimeEnum.build(TypeJourneyTimeEnum.working.name),
                TypeJourneyTimeEnum.working,
              );
            },
          );

          test(
            'build throws exception for invalid name',
            () {
              expect(
                () => TypeJourneyTimeEnum.build('invalidName'),
                throwsException,
              );
            },
          );
        },
      );
    },
  );
}
