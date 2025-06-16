import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {
  @override
  late DateTime lastDateTime;
}

class MockWorkIndicatorCubit
    extends MockBloc<WorkIndicatorCubit, WorkIndicatorState>
    implements WorkIndicatorCubit {}

class MockShowBottomSheetUsecase extends Mock
    implements IShowBottomSheetUsecase {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late TimerBloc timerBloc;
  late IShowBottomSheetUsecase showBottomSheetUsecase;
  late WorkIndicatorCubit workIndicatorCubit;

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

  setUp(
    () {
      workIndicatorCubit = MockWorkIndicatorCubit();
      showBottomSheetUsecase = MockShowBottomSheetUsecase();
      timerBloc = MockTimerBloc();

      when(
        () => timerBloc.state,
      ).thenReturn(
        TimerClockState(dateTime: DateTime.now()),
      );

      when(
        () => workIndicatorCubit.state,
      ).thenReturn(
        WorkIndicatorUpdate(),
      );

      when(
        () => workIndicatorCubit.isWorkInProgress,
      ).thenReturn(
        false,
      );
    },
  );
  testWidgets(
    'ClockWidgetTest time validation pt',
    (tester) async {
      timerBloc.lastDateTime = DateTime(2023, 4, 27, 10, 15, 33);

      Widget widget = buildWidget(
        'pt',
        ClockWidget(
          timerBloc: timerBloc,
          activeTimer: true,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
        ),
      );

      await tester.pumpWidget(widget);

      final weekFinder = find.text('10:15');
      expect(weekFinder, findsOneWidget);

      final secondFinder = find.text('33');
      expect(secondFinder, findsOneWidget);

      final dayStringFinder = find.text('Quinta-feira - 27 de abril de 2023');
      expect(dayStringFinder, findsOneWidget);

      final pmFinder = find.text('PM');
      expect(pmFinder, findsNothing);

      final amFinder = find.text('AM');
      expect(amFinder, findsNothing);
    },
  );

  testWidgets(
    'ClockWidgetTest time validation en',
    (tester) async {
      timerBloc.lastDateTime = DateTime(2023, 4, 27, 10, 15, 05);

      Widget widget = buildWidget(
        'en',
        ClockWidget(
          timerBloc: timerBloc,
          activeTimer: true,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
        ),
      );
      await tester.pumpWidget(widget);

      final weekFinder = find.text('10:15');
      expect(weekFinder, findsOneWidget);

      final secondFinder = find.text('05');
      expect(secondFinder, findsOneWidget);

      final pmFinder = find.text('PM');
      expect(pmFinder, findsNothing);

      final amFinder = find.text('AM');
      expect(amFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Displays icon indicating facial recognition is running test',
    (tester) async {
      BuildContext tBuildContext = FakeBuildContext();
      Widget tContentWidget = const Text('content');

      registerFallbackValue(tBuildContext);
      registerFallbackValue(tContentWidget);

      when(
        () => workIndicatorCubit.isWorkInProgress,
      ).thenReturn(
        true,
      );

      when(
        () => showBottomSheetUsecase.call(
          content: any(named: 'content'),
          context: any(named: 'context'),
        ),
      ).thenAnswer(
        (_) async => {true},
      );

      timerBloc.lastDateTime = DateTime(2023, 4, 27, 10, 15, 05);

      Widget widget = buildWidget(
        'en',
        ClockWidget(
          timerBloc: timerBloc,
          activeTimer: true,
          workIndicatorCubit: workIndicatorCubit,
          showBottomSheetUsecase: showBottomSheetUsecase,
        ),
      );

      await tester.pumpWidget(widget);

      Finder iconFinder = find.byIcon(FontAwesomeIcons.rotate);
      expect(iconFinder, findsOneWidget);
      await tester.tap(iconFinder);
    },
  );

  testWidgets(
    'dont show face recognition sync test',
    (tester) async {
      BuildContext tBuildContext = FakeBuildContext();
      Widget tContentWidget = const Text('content');

      registerFallbackValue(tBuildContext);
      registerFallbackValue(tContentWidget);

      timerBloc.lastDateTime = DateTime(2023, 4, 27, 10, 15, 05);

      Widget widget = buildWidget(
        'en',
        ClockWidget(
          timerBloc: timerBloc,
          activeTimer: true,
          showFaceRecognitionSync: false,
        ),
      );

      await tester.pumpWidget(widget);

      Finder iconFinder = find.byIcon(FontAwesomeIcons.rotate);
      expect(iconFinder, findsNothing);
    },
  );
}
