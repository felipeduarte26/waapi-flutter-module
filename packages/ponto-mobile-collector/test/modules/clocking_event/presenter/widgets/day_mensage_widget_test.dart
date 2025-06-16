import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/widgets/day_mensage_widget.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

void main() {
  const String name = 'Name';

  Widget buildWidget(Widget widget) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: const Locale('pt'),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: widget,
          ),
        ),
      ),
    );
  }

  group(
    'DayMessageWidget',
    () {
      testWidgets(
        'Good morning test',
        (tester) async {
          DateTime day = DateTime.parse('2023-07-12 10:59:33');

          Widget widget = buildWidget(
            DayMessageWidget(
              fullName: name,
              day: day,
            ),
          );

          await tester.pumpWidget(widget);

          final textFinder = find.text('Bom dia, Name');
          expect(textFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Good afternoon test',
        (tester) async {
          DateTime day = DateTime.parse('2023-07-12 13:59:33');

          Widget widget = buildWidget(
            DayMessageWidget(
              fullName: name,
              day: day,
            ),
          );

          await tester.pumpWidget(widget);

          final textFinder = find.text('Boa tarde, Name');
          expect(textFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Goodnight test',
        (tester) async {
          DateTime day = DateTime.parse('2023-07-12 18:59:33');

          Widget widget = buildWidget(
            DayMessageWidget(
              fullName: name,
              day: day,
            ),
          );

          await tester.pumpWidget(widget);

          final textFinder = find.text('Boa noite, Name');
          expect(textFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Goodnight test without name',
        (tester) async {
          DateTime day = DateTime.parse('2023-07-12 18:59:33');

          Widget widget = buildWidget(
            DayMessageWidget(
              day: day,
            ),
          );

          await tester.pumpWidget(widget);

          final textFinder = find.text('Boa noite!');
          expect(textFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Hide hand test',
        (tester) async {
          DateTime day = DateTime.parse('2023-07-12 18:59:33');

          Widget widget = buildWidget(
            DayMessageWidget(
              day: day,
            ),
          );

          await tester.pumpWidget(widget);

          final textFinder = find.text('Boa noite!');
          expect(textFinder, findsOneWidget);
        },
      );
    },
  );
}
