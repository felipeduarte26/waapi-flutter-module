import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockShowBottomSheetUsecase extends Mock implements IShowBottomSheetUsecase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late IShowBottomSheetUsecase showBottomSheetUsecase = MockShowBottomSheetUsecase();

  WorkdayIndicators workdayIndicators = WorkdayIndicators(
    clockingEvents: [
      DateTime.parse('2023-03-18T08:00:00.000Z'),
      DateTime.parse('2023-03-18T12:00:00.000Z'),
      DateTime.parse('2023-03-18T13:30:00.000Z'),
      DateTime.parse('2023-03-18T17:30:00.000Z'),
    ],
  );

  WorkdayIndicators workdayIndicatorsEmpty = WorkdayIndicators(
    clockingEvents: [],
  );

  Widget getWidget(String locale, Widget widget) {
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
    'No clocking Event on Tap expand - es',
    (tester) async {
      bool tapIndiactor = false;

      await tester.pumpWidget(
        getWidget(
          'es',
          TodaysWorkday(
            workdayIndicators: workdayIndicatorsEmpty,
            expanded: true,
            onExpandedPressed: () => tapIndiactor = true,
            showBottomSheetUsecase: showBottomSheetUsecase,
          ),
        ),
      );

      var ilustrationFinder = find.byType(SvgPicture);

      var calendarIconFinder = find.byIcon(
        FontAwesomeIcons.solidCalendarCheck,
      );

      var angleUpIconFinder = find.byIcon(
        FontAwesomeIcons.angleUp,
      );

      var angleDownIconFinder = find.byIcon(
        FontAwesomeIcons.angleDown,
      );

      var noClockingEventTextFinder = find.text('No hay marcaciones registradas hoy.');
      var titleFinder = find.text('Marcaciones de hoy');

      expect(noClockingEventTextFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(ilustrationFinder, findsOneWidget);
      expect(angleUpIconFinder, findsOneWidget);
      expect(calendarIconFinder, findsOneWidget);
      expect(angleDownIconFinder, findsNothing);

      var tapFinder = find.byType(SeniorCard);
      await tester.tap(tapFinder);
      await tester.pump();

      expect(tapIndiactor, true);

      await tester.pumpWidget(
        getWidget(
          'es',
          TodaysWorkday(
            workdayIndicators: workdayIndicatorsEmpty,
            expanded: false,
            showBottomSheetUsecase: showBottomSheetUsecase,
          ),
        ),
      );

      ilustrationFinder = find.byType(SvgPicture);

      calendarIconFinder = find.byIcon(
        FontAwesomeIcons.solidCalendarCheck,
      );

      angleUpIconFinder = find.byIcon(
        FontAwesomeIcons.angleUp,
      );

      angleDownIconFinder = find.byIcon(
        FontAwesomeIcons.angleDown,
      );

      expect(noClockingEventTextFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(angleDownIconFinder, findsOneWidget);
      expect(calendarIconFinder, findsOneWidget);
      expect(ilustrationFinder, findsNothing);
      expect(angleUpIconFinder, findsNothing);
    },
  );

  testWidgets(
    'even clocking Events on Tap expand - en',
    (tester) async {
      await tester.pumpWidget(
        getWidget(
          'en',
          TodaysWorkday(
            workdayIndicators: workdayIndicators,
            expanded: true,
            showBottomSheetUsecase: showBottomSheetUsecase,
          ),
        ),
      );

      var calendarIconFinder = find.byIcon(
        FontAwesomeIcons.solidCalendarCheck,
      );

      var titleFinder = find.text('Today\'s clocking events');

      var angleUpIconFinder = find.byIcon(
        FontAwesomeIcons.angleUp,
      );

      var angleDownIconFinder = find.byIcon(
        FontAwesomeIcons.angleDown,
      );

      var firstClockingEventFinder = find.text('8:00 AM');
      var secondClockingEventFinder = find.text('12:00 PM');
      var thirdClockingEventFinder = find.text('1:30 PM');
      var lastClockingEventFinder = find.text('5:30 PM');

      var dividerTextFinder = find.text(' 1h 30min break');
      var workedHoursFinder = find.text('Hours worked today');
      var breacksFinder = find.text('Breaks');
      var lastClockingEventsFinder = find.text('Last clocking events');

      expect(titleFinder, findsOneWidget);
      expect(angleUpIconFinder, findsOneWidget);
      expect(calendarIconFinder, findsOneWidget);
      expect(dividerTextFinder, findsOneWidget);
      expect(workedHoursFinder, findsOneWidget);
      expect(breacksFinder, findsOneWidget);

      expect(firstClockingEventFinder, findsOneWidget);
      expect(secondClockingEventFinder, findsOneWidget);
      expect(thirdClockingEventFinder, findsOneWidget);
      expect(lastClockingEventFinder, findsOneWidget);

      expect(angleDownIconFinder, findsNothing);
      expect(lastClockingEventsFinder, findsNothing);

      await tester.pumpWidget(
        getWidget(
          'en',
          TodaysWorkday(
            workdayIndicators: workdayIndicators,
            expanded: false,
            showBottomSheetUsecase: showBottomSheetUsecase,
          ),
        ),
      );

      calendarIconFinder = find.byIcon(
        FontAwesomeIcons.solidCalendarCheck,
      );

      titleFinder = find.text('Today\'s clocking events');

      angleUpIconFinder = find.byIcon(
        FontAwesomeIcons.angleUp,
      );

      angleDownIconFinder = find.byIcon(
        FontAwesomeIcons.angleDown,
      );

      firstClockingEventFinder = find.text('8:00 AM');
      secondClockingEventFinder = find.text('12:00 PM');
      thirdClockingEventFinder = find.text('1:30 PM');
      lastClockingEventFinder = find.text('5:30 PM');

      dividerTextFinder = find.text(' 1h 30min break');
      workedHoursFinder = find.text('Hours worked today');
      breacksFinder = find.text('Breaks');
      lastClockingEventsFinder = find.text('Last clocking events');

      expect(titleFinder, findsOneWidget);
      expect(angleDownIconFinder, findsOneWidget);
      expect(calendarIconFinder, findsOneWidget);
      expect(lastClockingEventsFinder, findsOneWidget);

      expect(firstClockingEventFinder, findsNothing);
      expect(secondClockingEventFinder, findsNothing);
      expect(thirdClockingEventFinder, findsOneWidget);
      expect(lastClockingEventFinder, findsOneWidget);

      expect(angleUpIconFinder, findsNothing);
      expect(dividerTextFinder, findsNothing);
      expect(workedHoursFinder, findsNothing);
      expect(breacksFinder, findsNothing);
    },
  );

  testWidgets(
    'odd clocking Events on Tap expand - pt',
    (tester) async {
      WorkdayIndicators workdayIndicatorsLocal = WorkdayIndicators(
        clockingEvents: [
          DateTime.parse('2023-03-18T08:00:00.000Z'),
          DateTime.parse('2023-03-18T12:00:00.000Z'),
          DateTime.parse('2023-03-18T13:30:00.000Z'),
          DateTime.parse('2023-03-18T17:30:00.000Z'),
          DateTime.parse('2023-03-18T18:30:00.000Z'),
        ],
      );

      await tester.pumpWidget(
        getWidget(
          'pt',
          TodaysWorkday(
            workdayIndicators: workdayIndicatorsLocal,
            expanded: true,
            showBottomSheetUsecase: showBottomSheetUsecase,
          ),
        ),
      );

      var calendarIconFinder = find.byIcon(
        FontAwesomeIcons.solidCalendarCheck,
      );

      var titleFinder = find.text('Marcações de hoje');

      var angleUpIconFinder = find.byIcon(
        FontAwesomeIcons.angleUp,
      );

      var angleDownIconFinder = find.byIcon(
        FontAwesomeIcons.angleDown,
      );

      var firstClockingEventFinder = find.text('08:00');
      var secondClockingEventFinder = find.text('12:00');
      var thirdClockingEventFinder = find.text('13:30');
      var fourthClockingEventFinder = find.text('17:30');
      var lastClockingEventFinder = find.text('18:30');

      var dividerTextFinder = find.text('Intervalo de  1h 30min');
      var secondDividerTextFinder = find.text('Intervalo de  1h');

      var workedHoursFinder = find.text('Horas trabalhadas hoje');
      var breacksFinder = find.text('Intervalos');
      var lastClockingEventsFinder = find.text('Última marcação');

      expect(titleFinder, findsOneWidget);
      expect(angleUpIconFinder, findsOneWidget);
      expect(calendarIconFinder, findsOneWidget);

      expect(workedHoursFinder, findsOneWidget);
      expect(breacksFinder, findsOneWidget);

      expect(firstClockingEventFinder, findsOneWidget);
      expect(secondClockingEventFinder, findsOneWidget);
      expect(thirdClockingEventFinder, findsOneWidget);
      expect(fourthClockingEventFinder, findsOneWidget);
      expect(lastClockingEventFinder, findsOneWidget);

      expect(angleDownIconFinder, findsNothing);
      expect(lastClockingEventsFinder, findsNothing);

      expect(dividerTextFinder, findsOneWidget);
      expect(secondDividerTextFinder, findsOneWidget);

      await tester.pumpWidget(
        getWidget(
          'pt',
          TodaysWorkday(
            workdayIndicators: workdayIndicatorsLocal,
            expanded: false,
            showBottomSheetUsecase: showBottomSheetUsecase,
          ),
        ),
      );

      calendarIconFinder = find.byIcon(
        FontAwesomeIcons.solidCalendarCheck,
      );

      titleFinder = find.text('Marcações de hoje');

      angleUpIconFinder = find.byIcon(
        FontAwesomeIcons.angleUp,
      );

      angleDownIconFinder = find.byIcon(
        FontAwesomeIcons.angleDown,
      );

      firstClockingEventFinder = find.text('08:00');
      secondClockingEventFinder = find.text('12:00');
      thirdClockingEventFinder = find.text('13:30');
      fourthClockingEventFinder = find.text('17:30');
      lastClockingEventFinder = find.text('18:30');

      dividerTextFinder = find.text('Intervalo de  1h 30min');
      secondDividerTextFinder = find.text('Intervalo de  1h');
      workedHoursFinder = find.text('Horas trabalhadas hoje');
      breacksFinder = find.text('Intervalos');
      lastClockingEventsFinder = find.text('Última marcação');

      expect(titleFinder, findsOneWidget);
      expect(angleDownIconFinder, findsOneWidget);
      expect(calendarIconFinder, findsOneWidget);
      expect(lastClockingEventsFinder, findsOneWidget);

      expect(firstClockingEventFinder, findsNothing);
      expect(secondClockingEventFinder, findsNothing);
      expect(thirdClockingEventFinder, findsNothing);
      expect(fourthClockingEventFinder, findsNothing);
      expect(lastClockingEventFinder, findsOneWidget);

      expect(angleUpIconFinder, findsNothing);
      expect(dividerTextFinder, findsNothing);
      expect(secondDividerTextFinder, findsNothing);
      expect(workedHoursFinder, findsNothing);
      expect(breacksFinder, findsNothing);
    },
  );

  testWidgets('HoursWorkedInfoWidget shows info about the "hours worked" field - pt', (tester) async {
    await tester.pumpWidget(
      getWidget(
        'pt',
        const HoursWorkedInfoWidget(),
      ),
    );

    var workedHoursFinder = find.text('Horas trabalhadas hoje');
    var infoTextFinder = find.text(
      'A quantidade de horas é calculada quando existem marcações em pares (entrada e saída), portanto o total é atualizado apenas ao registrar o fim de um período.',
    );
    var infoUnderstoodButtonFinder = find.text('Entendi');

    expect(workedHoursFinder, findsOneWidget);
    expect(infoTextFinder, findsOneWidget);
    expect(infoUnderstoodButtonFinder, findsOneWidget);
  });

  testWidgets('HoursWorkedInfoWidget shows info about the "hours worked" field - es', (tester) async {
    await tester.pumpWidget(
      getWidget(
        'es',
        const HoursWorkedInfoWidget(),
      ),
    );

    var workedHoursFinder = find.text('Horas trabajadas hoy');
    var infoTextFinder = find.text(
      'Se calcula la cantidad de horas cuando hay marcaciones en pares (entrada y salida), así que solo se actualiza el total al registrar el fin de un período.',
    );
    var infoUnderstoodButtonFinder = find.text('Entendí');

    expect(workedHoursFinder, findsOneWidget);
    expect(infoTextFinder, findsOneWidget);
    expect(infoUnderstoodButtonFinder, findsOneWidget);
  });

  testWidgets('HoursWorkedInfoWidget shows info about the "hours worked" field - en', (tester) async {
    await tester.pumpWidget(
      getWidget(
        'en',
        const HoursWorkedInfoWidget(),
      ),
    );

    var workedHoursFinder = find.text('Hours worked today');
    var infoTextFinder = find.text(
      'The amount of hours is calculated when there are paired clocking events (clock-in and clock-out), so the total is updated only when recording the end of a period.',
    );
    var infoUnderstoodButtonFinder = find.text('Understood');

    expect(workedHoursFinder, findsOneWidget);
    expect(infoTextFinder, findsOneWidget);
    expect(infoUnderstoodButtonFinder, findsOneWidget);
  });

  testWidgets(
    'show hours worked info',
    (tester) async {
      GlobalKey navigatorKey = GlobalKey();
      showBottomSheetUsecase = MockShowBottomSheetUsecase();
      BuildContext context = MockBuildContext();
      List<Widget> content = [const HoursWorkedInfoWidget()];
      dynamic retorno = true;

      registerFallbackValue(context);
      registerFallbackValue(content);

      when(
        () => showBottomSheetUsecase.call(
          content: any(named: 'content'),
          context: any(named: 'context'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(retorno),
      );

      TodaysWorkday todaysWorkday = TodaysWorkday(
        workdayIndicators: workdayIndicators,
        expanded: true,
        key: navigatorKey,
        showBottomSheetUsecase: showBottomSheetUsecase,
      );

      await tester.pumpWidget(
        getWidget(
          'en',
          todaysWorkday,
        ),
      );

      var iconFinder = find.byIcon(FontAwesomeIcons.circleInfo);
      await tester.tap(iconFinder);

      var infoUnderstoodButtonFinder = find.text('Understood');

      verify(
        () => showBottomSheetUsecase.call(
          content: any(named: 'content'),
          context: any(named: 'context'),
        ),
      ).called(1);
      expect(infoUnderstoodButtonFinder, findsNothing);
      verifyNoMoreInteractions(showBottomSheetUsecase);
    },
  );
}
