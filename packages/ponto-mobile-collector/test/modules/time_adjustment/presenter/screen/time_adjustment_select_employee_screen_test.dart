import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/employee_item_widget.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/screen/time_adjustment_select_employee_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../mocks/employee_item_entity_mock.dart';

class MockUtils extends Mock implements IUtils {}

class MockPeriodBloc extends MockBloc<PeriodEvent, PeriodState>
    implements PeriodBloc {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockTimerAdjustmentBloc extends Mock implements TimerAdjustmentBloc {}

class MockTimeAdjustmentSelectEmployeeBloc extends Mock
    implements TimeAdjustmentSelectEmployeeBloc {}

void main() {
  late Widget widget;
  late IUtils utils;
  late NavigatorService navigatorService;
  late TimerAdjustmentBloc timerAdjustmentBloc;
  late TimeAdjustmentSelectEmployeeBloc timeAdjustmentSelectEmployeeBloc;
  //late Object? routeArguments;

  var userIdentifier = 'username@tenant.com.br';

  // routeArguments = {
  // 'username': userIdentifier,
  //};

  String tMaskCpf = '***.999.888-**';

  List<String>? employeesSelected = [];

  Widget getWidget(Widget widget) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: const Locale('pt'),
          child: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }

  setUp(() {
    utils = MockUtils();
    navigatorService = MockNavigatorService();
    timerAdjustmentBloc = MockTimerAdjustmentBloc();
    timeAdjustmentSelectEmployeeBloc = MockTimeAdjustmentSelectEmployeeBloc();

    when(
      () => utils.maskCPF(cpf: any(named: 'cpf')),
    ).thenReturn(tMaskCpf);

    when(() => timeAdjustmentSelectEmployeeBloc.state)
        .thenReturn(MultipleReadyContent());

    when(() => timeAdjustmentSelectEmployeeBloc.stream).thenAnswer(
      (_) => Stream.fromIterable(
        [
          MultipleEmployeeSearchInitial(),
          MultipleReadyContent(),
        ],
      ),
    );

    when(() => timeAdjustmentSelectEmployeeBloc.employees).thenReturn([
      employeeItemEntityMock,
      employeeItemEntityMock,
      employeeItemEntityMock,
    ]);

    widget = getWidget(
      TimeAdjustmentSelectEmployeeScreen(
        timerAdjustmentBloc: timerAdjustmentBloc,
        utils: utils,
        navigatorService: navigatorService,
        routeArguments: userIdentifier,
        timeAdjustmentSelectEmployeeBloc: timeAdjustmentSelectEmployeeBloc,
      ),
    );
  });

  group('TimeAdjustmentSelectEmployeeScreen test', () {
    testWidgets('show loading test', (tester) async {
      when(() => timeAdjustmentSelectEmployeeBloc.state)
          .thenReturn(MultipleEmployeeSearchInitial());

      await tester.pumpWidget(widget);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('show employee list test', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(EmployeeItemWidget), findsNWidgets(3));
      expect(find.text(tMaskCpf), findsNWidgets(3));
      expect(find.text(employeeItemEntityMock.name), findsNWidgets(3));
    });

    testWidgets('IconButton onPressed callback', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byIcon(FontAwesomeIcons.magnifyingGlass), findsOneWidget);

      await tester.tap(find.byIcon(FontAwesomeIcons.magnifyingGlass));
    });

    testWidgets('should unmark employee as selected when tapped again',
        (tester) async {
      await tester.pumpWidget(widget);

      await tester.tap(
        find.byType(EmployeeItemWidget).first,
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.byType(EmployeeItemWidget).first,
      );

      await tester.pumpAndSettle();

      final employeeItemWidget = tester.widget<EmployeeItemWidget>(
        find.byType(EmployeeItemWidget).first,
      );

      expect(employeeItemWidget.selected, isFalse);
    });

    testWidgets('should show search field', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(SeniorTextField), findsOneWidget);
    });

    testWidgets('should search for employees when typing in the search field',
        (tester) async {
      await tester.pumpWidget(widget);

      await tester.enterText(find.byType(SeniorTextField), 'João');
      await tester.testTextInput.receiveAction(TextInputAction.done);
    });

    testWidgets('should clear search when pressing the clear button',
        (tester) async {
      await tester.pumpWidget(widget);

      await tester.enterText(find.byType(SeniorTextField), 'João');
      await tester.tap(find.byIcon(FontAwesomeIcons.magnifyingGlass));
    });

    testWidgets(
        'should remove all selected employees when pressing the "Remove Filter" button',
        (tester) async {
      await tester.pumpWidget(widget);

      employeesSelected.add('1'); // Simulate an employee being selected
      employeesSelected.remove('1');

      await tester.pumpWidget(widget);
      await tester.tap(find.text('Fechar'));

      expect(employeesSelected, isEmpty);
    });
  });
}
