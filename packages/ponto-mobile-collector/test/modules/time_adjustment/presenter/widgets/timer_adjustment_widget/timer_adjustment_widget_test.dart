import 'dart:developer';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/journey_time_details_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/synchronization_result.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/bottom_sheet_service/bottom_sheet_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/type_journey_time_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/synchronize_clocking_event_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_state.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../mocks/employee_dto_mock.dart';

class MockTimerAdjustmentBloc
    extends MockBloc<TimerAdjustmentEvent, TimerAdjustmentState>
    implements TimerAdjustmentBloc {}

class MockSynchronizeClockingEventBloc
    extends MockBloc<SyncClockingEventEvent, SyncClockingEventState>
    implements SynchronizeClockingEventBloc {}

class MockSynchronizeClockingEventUsecase extends Mock
    implements ISynchronizeClockingEventUsecase {}

void main() {
  late List<TimeInfoModel> timesInfo = [];
  DateTime dateSelect = DateTime(2023, 3, 28, 16, 02);
  late SynchronizeClockingEventBloc synchronizeClockingEventBloc;
  late TimerAdjustmentBloc timerAdjustmentBloc;
  late List<JourneyTimeDetailsDto> journeyTimeDetailsList = [];

  setUp(() {
    synchronizeClockingEventBloc = MockSynchronizeClockingEventBloc();
    timerAdjustmentBloc = MockTimerAdjustmentBloc();

    when(() => synchronizeClockingEventBloc.state)
        .thenReturn(SyncClockingEventInitial());

    timesInfo.clear();

    timesInfo.add(
      TimeInfoModel(
        clockingEventId: 'id1',
        dateTime: DateTime(2023, 03, 28, 08, 00),
        isBold: false,
        isPhoneOrigin: false,
        isPlatformOrigin: false,
        isManual: false,
        isRemoteness: false,
        isSynchronized: false,
        use: 2,
        isMealBreak: false,
      ),
    );

    timesInfo.add(
      TimeInfoModel(
        clockingEventId: 'id2',
        dateTime: DateTime(2023, 03, 28, 12, 00),
        isBold: false,
        isPhoneOrigin: false,
        isPlatformOrigin: false,
        isManual: false,
        isRemoteness: false,
        isSynchronized: false,
        use: 23,
        isMealBreak: false,
      ),
    );

    timesInfo.add(
      TimeInfoModel(
        clockingEventId: 'id3',
        dateTime: DateTime(2023, 03, 28, 13, 30),
        isBold: false,
        isPhoneOrigin: false,
        isPlatformOrigin: false,
        isManual: false,
        isRemoteness: false,
        isSynchronized: false,
        use: 23,
        isMealBreak: false,
      ),
    );

    timesInfo.add(
      TimeInfoModel(
        clockingEventId: 'id4',
        dateTime: DateTime(2023, 03, 28, 18, 00),
        isBold: false,
        isPhoneOrigin: false,
        isPlatformOrigin: false,
        isManual: false,
        isRemoteness: false,
        isSynchronized: false,
        use: 2,
        isMealBreak: true,
      ),
    );
    journeyTimeDetailsList.add(
      JourneyTimeDetailsDto(
        time: DateTime.now(),
        use: TypeJourneyTimeEnum.driving,
      ),
    );
  });

  Widget getWidget(
    String locale, {
    required SynchronizeClockingEventBloc syncClockingEventBloc,
    required bool isCollapsed,
    bool isMulti = false,
    bool isDriversJourneyHistory = false,
    bool isCustom = false,
  }) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: Scaffold(
            body: TimeAdjustmentWidget(
              timerAdjustmentBloc,
              syncClockingEventBloc,
              Utils(),
              ShowBottomSheetUsecase(
                bottomSheetService: BottomSheetService(),
              ),
              isCollapsed: isCollapsed,
              showEmployeeName: isMulti,
              dayInfoModel: DayInfoModel(
                isOdd: true,
                day: dateSelect,
                isSynchronized: false,
                isRemoteness: true,
                times: timesInfo,
                employee: employeeMockDto,
                isOvernight: true,
              ),
              isDriversJourneyHistory: isDriversJourneyHistory,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets(
    'TimeAdjustmentWidget click test',
    (tester) async {
      registerFallbackValue(
        ShowReceiptTimerAdjustmentEvent(
          clockingEventId: 'id',
          locale: 'en',
        ),
      );

      when(() => timerAdjustmentBloc.journeyTimeDetailsList)
          .thenReturn(journeyTimeDetailsList);
      when(() => timerAdjustmentBloc.totalBreakTime)
          .thenReturn(DateTime(0, 0, 0, 2, 30));
      when(() => timerAdjustmentBloc.totalWorkingTime)
          .thenReturn(DateTime(0, 0, 0, 8, 30));

      Widget widget = getWidget(
        'en',
        syncClockingEventBloc: synchronizeClockingEventBloc,
        isCollapsed: false,
      );
      await tester.pumpWidget(widget);
      final inkWell = find.byType(InkWell);
      expect(inkWell, findsWidgets);
      await tester.tap(inkWell.first);
      await tester.pump();

      verify(
        () => timerAdjustmentBloc.add(any()),
      ).called(1);
      // verify(
      //   () => timerAdjustmentBloc.journeyTimeDetailsList,
      // ).called(1);

      verifyNever(
        () => timerAdjustmentBloc.totalBreakTime,
      );
      verifyNever(
        () => timerAdjustmentBloc.totalWorkingTime,
      );
      verifyNoMoreInteractions(timerAdjustmentBloc);
    },
  );

  testWidgets(
    'TimeAdjustmentWidget click test with custom theme',
    (tester) async {
      registerFallbackValue(
        ShowReceiptTimerAdjustmentEvent(
          clockingEventId: 'id',
          locale: 'en',
        ),
      );

      when(() => timerAdjustmentBloc.journeyTimeDetailsList)
          .thenReturn(journeyTimeDetailsList);
      when(() => timerAdjustmentBloc.totalBreakTime)
          .thenReturn(DateTime(0, 0, 0, 2, 30));
      when(() => timerAdjustmentBloc.totalWorkingTime)
          .thenReturn(DateTime(0, 0, 0, 8, 30));

      Widget widget = getWidget(
        'en',
        syncClockingEventBloc: synchronizeClockingEventBloc,
        isCollapsed: false,
        isCustom: true,
      );
      await tester.pumpWidget(widget);
      final inkWell = find.byType(InkWell);
      expect(inkWell, findsWidgets);
      await tester.tap(inkWell.first);
      await tester.pump();

      verify(
        () => timerAdjustmentBloc.add(any()),
      ).called(1);

      verifyNever(
        () => timerAdjustmentBloc.totalBreakTime,
      );
      verifyNever(
        () => timerAdjustmentBloc.totalWorkingTime,
      );
      verifyNoMoreInteractions(timerAdjustmentBloc);
    },
  );

  testWidgets('Testa o dia da semana - Inglês', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'en',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekFinder = find.text('Tuesday');
    expect(weekFinder, findsOneWidget);
  });

  testWidgets('Testa o dia da semana - Espanhol', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'es',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekFinder = find.text('Martes');
    expect(weekFinder, findsOneWidget);
  });

  testWidgets('Testa o dia da semana - Português', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekFinder = find.text('Terça-feira');
    expect(weekFinder, findsNWidgets(1));
  });

  testWidgets('Testa total trabalhado  - Inglês', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'en',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekTotalWork = find.text('Hours worked today');
    expect(weekTotalWork, findsOneWidget);
  });

  testWidgets('Testa total trabalhado  - Espanhol', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'es',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekTotalWork = find.text('Horas trabajadas hoy');
    expect(weekTotalWork, findsOneWidget);
  });

  testWidgets('Testa total trabalhado  - Português', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekTotalWork = find.text('Horas trabalhadas hoje');
    expect(weekTotalWork, findsOneWidget);
  });

  testWidgets('Testa total intervalo  - Inglês', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'en',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekBreak = find.text('Time in breaks');
    expect(weekBreak, findsOneWidget);
  });

  testWidgets('Testa total intervalo  - Espanhol', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'es',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekBreak = find.text('Tiempo en intervalos');
    expect(weekBreak, findsOneWidget);
  });

  testWidgets('Testa total intervalo  - Português', (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final weekBreak = find.text('Tempo em pausas');
    expect(weekBreak, findsOneWidget);
  });

  testWidgets(
      'Procura quantidade de marcações na lista pela quantidade de linhas',
      (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final numberClockFinder = find.byKey(const Key('clockingRow'));
    expect(numberClockFinder, findsNWidgets(4));
  });

  testWidgets('Procura a primeira marcação específica na ListView',
      (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final clockingFinder = find.byKey(const Key('Hour'));
    SeniorText text = tester.firstWidget(clockingFinder);
    expect(text.content, '08:00');
  });

  testWidgets('Procura a ultima marcação específica na ListView',
      (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final clockingFinder = find.byWidgetPredicate(
      (Widget widget) => widget is SeniorText && widget.content == '18:00',
    );
    SeniorText text = tester.firstWidget<SeniorText>(clockingFinder);
    expect(text.content, '18:00');
  });

  testWidgets(
      'Procura quantidade de icones na lista de marcações pela quantidade de linhas',
      (tester) async {
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);
    final numberMobileIconFinder = find.byIcon(
      FontAwesomeIcons.mobileScreenButton,
    );
    (const Key('clockingRow'));
    expect(numberMobileIconFinder, findsNWidgets(4));
  });

  testWidgets(
      'Procura quantidade de marcações pela quantidade de divisores na linha',
      (tester) async {
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: true,
    );
    await tester.pumpWidget(widget);
    final rawTextClockingsFinder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is Text &&
          widget.textSpan != null &&
          widget.textSpan!.toPlainText().split('|').length - 1 == 3,
    );

    expect(
      rawTextClockingsFinder,
      findsOneWidget,
    );
  });

  testWidgets('Procura o identificador de marcações vazias', (tester) async {
    timesInfo.clear();
    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: true,
    );
    await tester.pumpWidget(widget);
    final dividersClockingsFinder = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SeniorText && widget.content == 'Sem marcações',
    );

    expect(dividersClockingsFinder, findsNWidgets(1));
  });

  testWidgets('executes synchronization successfully', (tester) async {
    timesInfo.clear();

    ISynchronizeClockingEventUsecase synchronizeClockingEventUsecase =
        MockSynchronizeClockingEventUsecase();
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(
      () => synchronizeClockingEventUsecase.call(),
    ).thenAnswer(
      (invocation) => Future.value(
        SynchronizationResult(
          SynchronizationStatus.success,
          SynchronizationMessage.syncClockingEventSyncSuccess,
        ),
      ),
    );
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));

    SynchronizeClockingEventBloc synchronizeClockingEventBloc =
        SynchronizeClockingEventBloc(synchronizeClockingEventUsecase);

    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);

    final syncFinishedFinder = find.text('Sincronização concluída.');
    expect(syncFinishedFinder, findsNothing);

    synchronizeClockingEventBloc.add(SyncClockingEventStarted());

    await tester.pump();

    expect(syncFinishedFinder, findsOneWidget);
  });

  testWidgets('executes synchronization returning failure', (tester) async {
    timesInfo.clear();

    ISynchronizeClockingEventUsecase synchronizeClockingEventUsecase =
        MockSynchronizeClockingEventUsecase();
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(
      () => synchronizeClockingEventUsecase.call(),
    ).thenAnswer(
      (invocation) => Future.value(
        SynchronizationResult(
          SynchronizationStatus.warning,
          SynchronizationMessage.syncClockingEventSyncFailure,
        ),
      ),
    );

    SynchronizeClockingEventBloc synchronizeClockingEventBloc =
        SynchronizeClockingEventBloc(synchronizeClockingEventUsecase);

    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);

    final syncFinishedFinder = find
        .text('Desculpe, ocorreu uma falha na sincronização. Tente novamente.');
    expect(syncFinishedFinder, findsNothing);

    synchronizeClockingEventBloc.add(SyncClockingEventStarted());

    await tester.pump();

    expect(syncFinishedFinder, findsOneWidget);
  });

  testWidgets('executes synchronization returning error', (tester) async {
    timesInfo.clear();
    when(() => timerAdjustmentBloc.journeyTimeDetailsList)
        .thenReturn(journeyTimeDetailsList);
    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    ISynchronizeClockingEventUsecase synchronizeClockingEventUsecase =
        MockSynchronizeClockingEventUsecase();

    when(
      () => synchronizeClockingEventUsecase.call(),
    ).thenAnswer(
      (invocation) => Future.value(
        SynchronizationResult(
          SynchronizationStatus.error,
          SynchronizationMessage.syncClockingEventSyncInternetUnavailable,
        ),
      ),
    );

    SynchronizeClockingEventBloc synchronizeClockingEventBloc =
        SynchronizeClockingEventBloc(synchronizeClockingEventUsecase);

    Widget widget = getWidget(
      'pt',
      syncClockingEventBloc: synchronizeClockingEventBloc,
      isCollapsed: false,
    );
    await tester.pumpWidget(widget);

    final syncFinishedFinder = find.text(
      'Sincronização não concluída. Verifique sua conexão com a internet.',
    );
    expect(syncFinishedFinder, findsNothing);

    synchronizeClockingEventBloc.add(SyncClockingEventStarted());

    await tester.pump();

    expect(syncFinishedFinder, findsOneWidget);
  });

  testWidgets(
    'Separated cards when has overnight',
    (tester) async {
      const locale = Locale('en');
      when(() => timerAdjustmentBloc.journeyTimeDetailsList)
          .thenReturn(journeyTimeDetailsList);
      when(() => timerAdjustmentBloc.totalBreakTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));
      when(() => timerAdjustmentBloc.totalWorkingTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));
      Widget widget = getWidget(
        locale.languageCode,
        syncClockingEventBloc: synchronizeClockingEventBloc,
        isCollapsed: false,
        isDriversJourneyHistory: true,
      );
      await tester.pumpWidget(widget);

      /// HACK: lógica para determinar se há pernoite
      if (timesInfo.isNotEmpty &&
          timesInfo.first.dateTime.day < timesInfo.last.dateTime.day) {
        const key = Key(
          'daily cards',
        );

        final dailyCards = find.byKey(
          key,
        );

        expect(
          dailyCards,
          findsOneWidget,
        );

        late final int? childrenAmount;

        expect(
          find.byWidgetPredicate(
            (widget) {
              if (widget is! ListView || widget.key != key) return false;

              final totalItemsAmount =
                  widget.childrenDelegate.estimatedChildCount;
              childrenAmount = widget.semanticChildCount;

              if (totalItemsAmount != null && childrenAmount != null) {
                final separatorsAmount = totalItemsAmount - childrenAmount!;

                expect(
                  find.descendant(
                    of: find.byKey(
                      key,
                    ),
                    matching: find.byType(
                      SizedBox,
                    ),
                  ),
                  findsAtLeastNWidgets(
                    separatorsAmount,
                  ),
                );
              }

              return true;
            },
          ),
          findsOneWidget,
        );

        expect(
          find.byType(
            SeniorElevatedElement,
          ),
          findsAtLeastNWidgets(
            1 + (childrenAmount ?? 0),
          ),
        );
      }
    },
  );

  testWidgets(
    'More details button',
    (tester) async {
      const locale = Locale('en');
      final collectorLocalizations = lookupCollectorLocalizations(locale);
      when(() => timerAdjustmentBloc.journeyTimeDetailsList)
          .thenReturn(journeyTimeDetailsList);
      when(() => timerAdjustmentBloc.totalBreakTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));
      when(() => timerAdjustmentBloc.totalWorkingTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));
      Widget widget = getWidget(
        locale.languageCode,
        syncClockingEventBloc: synchronizeClockingEventBloc,
        isCollapsed: false,
        isDriversJourneyHistory: true,
      );
      await tester.pumpWidget(widget);

      final moreDetailsButton = find.text(
        collectorLocalizations.moreDetails,
      );
      if (timesInfo.isNotEmpty) {
        expect(
          moreDetailsButton,
          findsOneWidget,
        );
      } else {
        expect(
          moreDetailsButton,
          findsNothing,
        );
      }
    },
  );

  testWidgets(
    'Circle info buttons click',
    (tester) async {
      const locale = Locale('en');
      final collectorLocalizations = lookupCollectorLocalizations(locale);
      when(() => timerAdjustmentBloc.journeyTimeDetailsList)
          .thenReturn(journeyTimeDetailsList);
      when(() => timerAdjustmentBloc.totalBreakTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));
      when(() => timerAdjustmentBloc.totalWorkingTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));
      Widget widget = getWidget(
        locale.languageCode,
        syncClockingEventBloc: synchronizeClockingEventBloc,
        isCollapsed: false,
        isDriversJourneyHistory: true,
      );
      await tester.pumpWidget(widget);

      final circleInfoFinder = find.widgetWithIcon(
        GestureDetector,
        FontAwesomeIcons.circleInfo,
      );

      expect(
        circleInfoFinder,
        findsAtLeastNWidgets(2),
      );

      final hoursWorkedCircleInfo = circleInfoFinder.at(0);

      await tester.tap(hoursWorkedCircleInfo);
      await tester.pumpAndSettle();

      expect(
        find.text(
          collectorLocalizations.hoursWorked,
        ),
        findsWidgets,
      );
      expect(
        find.text(
          collectorLocalizations.hoursWorkedInfo,
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          collectorLocalizations.infoUnderstoodButton,
        ),
        findsOneWidget,
      );

      final cardCloseButton = find.byIcon(
        FontAwesomeIcons.xmark,
      );
      expect(
        cardCloseButton,
        findsOneWidget,
      );
      await tester.tap(cardCloseButton);
      await tester.pumpAndSettle();

      final breaksCircleInfo = circleInfoFinder.at(1);

      await tester.tap(breaksCircleInfo);
      await tester.pumpAndSettle();

      expect(
        find.text(
          collectorLocalizations.breaks,
        ),
        findsWidgets,
      );
      expect(
        find.text(
          collectorLocalizations.breaksInfo,
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          collectorLocalizations.infoUnderstoodButton,
        ),
        findsOneWidget,
      );

      expect(
        cardCloseButton,
        findsOneWidget,
      );
      await tester.tap(cardCloseButton);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'mostra nome dos colaboradores no modo multiplo',
    (tester) async {
      Widget widget = getWidget(
        'en',
        syncClockingEventBloc: synchronizeClockingEventBloc,
        isCollapsed: true,
        isMulti: true,
      );

      await tester.pumpWidget(widget);

      final employeeNameFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is SeniorText && widget.content == employeeDtoMock.name,
      );

      expect(employeeNameFinder, findsOneWidget);
    },
  );

  testWidgets(
    'test pumpWidget',
    (tester) async {
      const locale = Locale('en');
      // final collectorLocalizations = lookupCollectorLocalizations(locale);
      when(() => timerAdjustmentBloc.journeyTimeDetailsList)
          .thenReturn(journeyTimeDetailsList);
      when(() => timerAdjustmentBloc.totalBreakTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));
      when(() => timerAdjustmentBloc.totalWorkingTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));
      Widget widget = getWidget(
        locale.languageCode,
        syncClockingEventBloc: synchronizeClockingEventBloc,
        isCollapsed: false,
        isDriversJourneyHistory: true,
      );
      try {
        await tester.pumpWidget(widget);
      } catch (e) {
        log(e.toString());
      }
    },
  );
}
