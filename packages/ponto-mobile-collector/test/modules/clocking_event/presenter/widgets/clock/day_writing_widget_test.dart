import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/widgets/clock/day_writing_widget.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

void main() {
  Widget buildWidget(String locale, Widget widget) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: widget,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'DayWritingWidget test',
    (tester) async {
      DateTime day = DateTime.parse('2023-07-12 10:59:33');
      Widget widget = buildWidget(
        'pt',
        DayWritingWidget(
          day: day,
        ),
      );

      await tester.pumpWidget(widget);

      final textFinder = find.text('Quarta-feira - 12 de julho de 2023');
      expect(textFinder, findsOneWidget);
    },
  );
}
