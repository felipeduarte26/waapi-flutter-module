import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/employee_item_widget.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/feedback_screen.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/filter_employee_select/filter_employee_select_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/filter_employee_select/filter_employee_select_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/filter_employee_select/filter_employee_select_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/screen/filter_employee_select_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/components/senior_button/senior_button_widget.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/components/senior_loading/senior_loading_widget.dart';
import 'package:senior_design_system/components/senior_text_field/components/senior_text_field_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

class MockFilterEmployeeSelectBloc extends Mock
    implements FilterEmployeeSelectBloc {}

class FakeFilterEmployeeSearchEvent extends Fake
    implements FilterEmployeeSearchEvent {}

class MockPeriodBloc extends Mock implements PeriodBloc {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockTimerAdjustmentBloc extends Mock implements TimerAdjustmentBloc {}

class MockIUtils extends Mock implements IUtils {}

class FakeFilterEmployeeSelectEvent extends Fake
    implements FilterEmployeeSelectEvent {}

void main() {
  late MockFilterEmployeeSelectBloc mockFilterEmployeeSelectBloc;
  late MockPeriodBloc mockPeriodBloc;
  late MockNavigatorService mockNavigatorService;
  late MockIUtils mockIUtils;
  late MockTimerAdjustmentBloc mockTimerAdjustmentBloc;

  Widget getWidget(String locale, Widget widget) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }

  setUpAll(() {
    // Registra o valor de fallback
    registerFallbackValue(FakeFilterEmployeeSelectEvent());
    registerFallbackValue(FakeFilterEmployeeSearchEvent());
  });

  setUp(() {
    mockFilterEmployeeSelectBloc = MockFilterEmployeeSelectBloc();
    mockPeriodBloc = MockPeriodBloc();
    mockNavigatorService = MockNavigatorService();
    mockIUtils = MockIUtils();
    mockTimerAdjustmentBloc = MockTimerAdjustmentBloc();

    when(() => mockFilterEmployeeSelectBloc.stream)
        .thenAnswer((_) => const Stream.empty());

    when(() => mockFilterEmployeeSelectBloc.employeesSelected).thenReturn([]);

    when(() => mockFilterEmployeeSelectBloc.employees).thenReturn([
      EmployeeItemEntity(
        id: '1',
        name: 'Jane Smith',
        identifier: '12345678901',
      ),
      EmployeeItemEntity(id: '2', name: 'John Doe', identifier: '98765432100'),
    ]);

    when(() => mockIUtils.maskCPF(cpf: any(named: 'cpf')))
        .thenReturn('123.456.789-01');
  });

  testWidgets('FilterEmployeeSelectScreen shows Initial',
      (WidgetTester tester) async {
    when(() => mockFilterEmployeeSelectBloc.state)
        .thenReturn(FilterEmployeeSearchInitial());

    Widget widget = getWidget(
      'pt',
      FilterEmployeeSelectScreen(
        periodBloc: mockPeriodBloc,
        filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
        utils: mockIUtils,
        navigatorService: mockNavigatorService,
        routeArguments: 'username',
        timerAdjustmentBloc: mockTimerAdjustmentBloc,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    expect(find.byType(LoadingWidget), findsOneWidget);
  });

  testWidgets('FilterEmployeeSelectScreen shows InProgress',
      (WidgetTester tester) async {
    when(() => mockFilterEmployeeSelectBloc.state)
        .thenReturn(FilterEmployeeSearchInProgress());

    when(() => mockFilterEmployeeSelectBloc.employeesSelected).thenReturn([]);

    Widget widget = getWidget(
      'pt',
      FilterEmployeeSelectScreen(
        periodBloc: mockPeriodBloc,
        filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
        utils: mockIUtils,
        navigatorService: mockNavigatorService,
        routeArguments: null,
        timerAdjustmentBloc: mockTimerAdjustmentBloc,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is SeniorTextField && widget.disabled == true,
      ),
      findsOneWidget,
    );
  });

  testWidgets('FilterEmployeeSelectScreen shows LoadMoreInProgress',
      (WidgetTester tester) async {
    when(() => mockFilterEmployeeSelectBloc.state)
        .thenReturn(FilterEmployeeSearchLoadMoreInProgress());

    when(() => mockFilterEmployeeSelectBloc.employeesSelected).thenReturn([]);

    Widget widget = getWidget(
      'pt',
      FilterEmployeeSelectScreen(
        periodBloc: mockPeriodBloc,
        filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
        utils: mockIUtils,
        navigatorService: mockNavigatorService,
        routeArguments: null,
        timerAdjustmentBloc: mockTimerAdjustmentBloc,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    expect(find.byType(SeniorLoading), findsOneWidget);
  });

  testWidgets('FilterEmployeeSelectScreen shows Failure',
      (WidgetTester tester) async {
    when(() => mockFilterEmployeeSelectBloc.state)
        .thenReturn(FilterEmployeeSearchFailure());

    Widget widget = getWidget(
      'pt',
      FilterEmployeeSelectScreen(
        periodBloc: mockPeriodBloc,
        filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
        utils: mockIUtils,
        navigatorService: mockNavigatorService,
        routeArguments: null,
        timerAdjustmentBloc: mockTimerAdjustmentBloc,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    await tester.press(find.byType(SeniorButton));

    expect(find.byType(FeedbackScreen), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is SeniorButton &&
            widget.label ==
                CollectorLocalizations.of(
                  tester.element(find.byType(FeedbackScreen)),
                ).facialTryAgain,
      ),
      findsOneWidget,
    );
  });

  testWidgets('FilterEmployeeSelectScreen shows Offline',
      (WidgetTester tester) async {
    when(() => mockFilterEmployeeSelectBloc.state)
        .thenReturn(FilterEmployeeSearchOffline());

    Widget widget = getWidget(
      'pt',
      FilterEmployeeSelectScreen(
        periodBloc: mockPeriodBloc,
        filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
        utils: mockIUtils,
        navigatorService: mockNavigatorService,
        routeArguments: null,
        timerAdjustmentBloc: mockTimerAdjustmentBloc,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.press(find.byType(SeniorButton));
    expect(find.byType(FeedbackScreen), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is SeniorButton &&
            widget.label ==
                CollectorLocalizations.of(
                  tester.element(find.byType(FeedbackScreen)),
                ).facialTryAgain,
      ),
      findsOneWidget,
    );
  });

  testWidgets('FilterEmployeeSelectScreen shows ReadyContent',
      (WidgetTester tester) async {
    final employees = [
      EmployeeItemEntity(id: '1', name: 'Jane Smith', identifier: '2'),
    ];

    when(() => mockFilterEmployeeSelectBloc.state)
        .thenReturn(FilterReadyContent());

    when(() => mockFilterEmployeeSelectBloc.employees).thenReturn(employees);

    Widget widget = getWidget(
      'pt',
      FilterEmployeeSelectScreen(
        periodBloc: mockPeriodBloc,
        filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
        utils: mockIUtils,
        navigatorService: mockNavigatorService,
        routeArguments: null,
        timerAdjustmentBloc: mockTimerAdjustmentBloc,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.press(find.byType(IconButton).first);
    await tester.pump();
    await tester.press(find.byType(IconButton).last);
    await tester.pump();
    await tester.enterText(find.byType(SeniorTextField), 'John Doe');
    await tester.pump();
    verify(() => mockFilterEmployeeSelectBloc.changeNameSearch('John Doe'))
        .called(1);

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(find.byType(EmployeeItemWidget), findsNWidgets(employees.length));

    for (var employee in employees) {
      expect(find.text(employee.name), findsOneWidget);
    }
  });
  testWidgets('FilterEmployeeSelectScreen shows no employees found',
      (WidgetTester tester) async {
    when(() => mockFilterEmployeeSelectBloc.state)
        .thenReturn(FilterReadyContent());
    when(() => mockFilterEmployeeSelectBloc.employees).thenReturn([]);

    Widget widget = getWidget(
      'pt',
      FilterEmployeeSelectScreen(
        periodBloc: mockPeriodBloc,
        filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
        utils: mockIUtils,
        navigatorService: mockNavigatorService,
        routeArguments: null,
        timerAdjustmentBloc: mockTimerAdjustmentBloc,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    expect(
      find.text(
        CollectorLocalizations.of(
          tester.element(find.byType(FilterEmployeeSelectScreen)),
        ).employeeList,
      ),
      findsOneWidget,
    );
    expect(find.byType(EmployeeItemWidget), findsNothing);
  });
testWidgets('FilterEmployeeSelectScreen allows multiple employee selection', (WidgetTester tester) async {
  final employees = [
    EmployeeItemEntity(id: '1', name: 'Jane Smith', identifier: '12345678901'),
    EmployeeItemEntity(id: '2', name: 'John Doe', identifier: '98765432100'),
  ];
  when(() => mockFilterEmployeeSelectBloc.add(any())).thenReturn(null);
  when(() => mockFilterEmployeeSelectBloc.state).thenReturn(FilterReadyContent());
  when(() => mockFilterEmployeeSelectBloc.employees).thenReturn(employees);
  when(() => mockFilterEmployeeSelectBloc.employeesSelected).thenReturn(['1']);

  Widget widget = getWidget(
    'pt',
    FilterEmployeeSelectScreen(
      periodBloc: mockPeriodBloc,
      filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
      utils: mockIUtils,
      navigatorService: mockNavigatorService,
      routeArguments: null,
      timerAdjustmentBloc: mockTimerAdjustmentBloc,
    ),
  );

  await tester.pumpWidget(widget);
  await tester.pump();

  await tester.tap(find.byType(EmployeeItemWidget).at(1));
  await tester.pump();

  verify(() => mockFilterEmployeeSelectBloc.add(any(),)).called(2);
});
testWidgets('FilterEmployeeSelectScreen clears filters when remove filter button is pressed', (WidgetTester tester) async {
  when(() => mockFilterEmployeeSelectBloc.add(any())).thenReturn(null);
  when(() => mockFilterEmployeeSelectBloc.state).thenReturn(FilterReadyContent());
  when(() => mockFilterEmployeeSelectBloc.employeesSelected).thenReturn(['1']);

  Widget widget = getWidget(
    'pt',
    FilterEmployeeSelectScreen(
      periodBloc: mockPeriodBloc,
      filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
      utils: mockIUtils,
      navigatorService: mockNavigatorService,
      routeArguments: null,
      timerAdjustmentBloc: mockTimerAdjustmentBloc,
    ),
  );

  await tester.pumpWidget(widget);
  await tester.pump();

  await tester.tap(find.text(CollectorLocalizations.of(tester.element(find.byType(FilterEmployeeSelectScreen))).removeFilter));
  await tester.pump();

  verify(() => mockFilterEmployeeSelectBloc.add(any())).called(2);
});

testWidgets('FilterEmployeeSelectScreen loads more employees on scroll to bottom', (WidgetTester tester) async {
  final employees = List.generate(
    20,
    (index) => EmployeeItemEntity(id: '$index', name: 'Employee $index', identifier: '1234567890$index'),
  );

  when(() => mockFilterEmployeeSelectBloc.add(any())).thenReturn(null);
  when(() => mockFilterEmployeeSelectBloc.state).thenReturn(FilterReadyContent());
  when(() => mockFilterEmployeeSelectBloc.employees).thenReturn(employees);

  Widget widget = getWidget(
    'pt',
    FilterEmployeeSelectScreen(
      periodBloc: mockPeriodBloc,
      filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
      utils: mockIUtils,
      navigatorService: mockNavigatorService,
      routeArguments: null,
      timerAdjustmentBloc: mockTimerAdjustmentBloc,
    ),
  );

  await tester.pumpWidget(widget);
  await tester.pump();

  final listFinder = find.byType(ListView);
  await tester.drag(listFinder, const Offset(0, -500));
  await tester.pump();

  verify(() => mockFilterEmployeeSelectBloc.add(any())).called(1);
});
  testWidgets('FilterEmployeeSelectScreen performs search on name input',
      (WidgetTester tester) async {
    // Configura o estado inicial do mock
    when(() => mockFilterEmployeeSelectBloc.state)
        .thenReturn(FilterReadyContent());

    // Configura o retorno do método getNameSearch
    when(() => mockFilterEmployeeSelectBloc.getNameSearch()).thenReturn('');

    // Configura o mock para aceitar chamadas para changeNameSearch
    when(() => mockFilterEmployeeSelectBloc.changeNameSearch(any()))
        .thenReturn(null);

    // Configura o mock para aceitar chamadas para add
    when(() => mockFilterEmployeeSelectBloc.add(any())).thenReturn(null);

    // Cria o widget de teste
    Widget widget = getWidget(
      'pt',
      FilterEmployeeSelectScreen(
        periodBloc: mockPeriodBloc,
        filterEmployeeSelectBloc: mockFilterEmployeeSelectBloc,
        utils: mockIUtils,
        navigatorService: mockNavigatorService,
        routeArguments: null,
        timerAdjustmentBloc: mockTimerAdjustmentBloc,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

    // Simula a entrada de texto no campo de busca
    await tester.enterText(find.byType(SeniorTextField), 'John Doe');
    await tester.pump();

    // Verifica se o método changeNameSearch foi chamado com o texto correto
    verify(() => mockFilterEmployeeSelectBloc.changeNameSearch('John Doe'))
        .called(1);

    // Simula o envio da busca
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Verifica se o evento de busca foi disparado
    verify(
      () => mockFilterEmployeeSelectBloc.add(any()),
    ).called(2);
  });
}
