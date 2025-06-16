import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/employee_search/employee_search_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/employee_search/employee_search_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/employee_item_widget.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/employee_select_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../mocks/employee_item_entity_mock.dart';

class MockEmployeeSearchCubit extends Mock implements EmployeeSearchCubit {}

class MockUtils extends Mock implements IUtils {}

class MockNavigatorService extends Mock implements NavigatorService {}

void main() {
  late Widget widget;
  late EmployeeSearchCubit employeeSearchCubit;
  late IUtils utils;
  late NavigatorService navigatorService;
  String tMaskCpf = '***.999.888-**';

  Widget getWidget(Widget widget) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        routes: const {
          // '/${FacialRecognitionRoutes.registrationFull}': (context) =>
          //     Text(tFacialRecognitionScreen),
          // tHomePath: (context) => Text(tHomeScreen),
        },
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
    employeeSearchCubit = MockEmployeeSearchCubit();
    navigatorService = MockNavigatorService();
    utils = MockUtils();

    when(
      () => utils.maskCPF(cpf: any(named: 'cpf')),
    ).thenReturn(tMaskCpf);

    when(
      () => employeeSearchCubit.loadMore(),
    ).thenAnswer((_) async => {});

    when(
      () => employeeSearchCubit.search(),
    ).thenAnswer((_) async => {});

    when(
      () => employeeSearchCubit.init(),
    ).thenAnswer((_) async => {});

    when(
      () => employeeSearchCubit.state,
    ).thenReturn(
      EmployeeSearchInitial(),
    );

    when(
      () => employeeSearchCubit.employees,
    ).thenReturn(
      [
        employeeItemEntityMock,
        employeeItemEntityMock,
        employeeItemEntityMock,
      ],
    );

    when(
      () => employeeSearchCubit.stream,
    ).thenAnswer(
      (_) => StreamController<EmployeeSearchInitial>().stream,
    );

    widget = getWidget(
      EmployeeSelectScreen(
        employeeSearchCubit: employeeSearchCubit,
        navigatorService: navigatorService,
        utils: utils,
      ),
    );
  });

  group('FaceRegistrationScreen', () {
    testWidgets('show loading test', (tester) async {
      when(
        () => employeeSearchCubit.state,
      ).thenReturn(
        EmployeeSearchInitial(),
      );

      await tester.pumpWidget(widget);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('show employee list test', (tester) async {
      when(
        () => employeeSearchCubit.state,
      ).thenReturn(
        EmployeeSearchSuccess(),
      );

      await tester.pumpWidget(widget);
      expect(find.byType(EmployeeItemWidget), findsNWidgets(3));
      expect(find.text(tMaskCpf), findsNWidgets(3));
      expect(find.text(employeeItemEntityMock.name), findsNWidgets(3));
      Finder buttonContinueFinder = find.text('Continuar');
      expect(buttonContinueFinder, findsOneWidget);
    });

    testWidgets('show not permission alert test', (tester) async {
      when(
        () => employeeSearchCubit.state,
      ).thenReturn(
        EmployeeSearchNotPermission(),
      );

      await tester.pumpWidget(widget);
      expect(find.text('Usuário sem permissão'), findsOneWidget);
      expect(
        find.text(
          'Por favor, contate o RH para verificar a permissão do seu usuário.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Tentar novamente'));

      verify(() => employeeSearchCubit.init()).called(1);
    });

    testWidgets('show offline alert test', (tester) async {
      when(
        () => employeeSearchCubit.state,
      ).thenReturn(
        EmployeeSearchOffline(),
      );

      await tester.pumpWidget(widget);
      expect(find.text('Sem conexão com a internet'), findsOneWidget);
      expect(
        find.text(
          'O cadastramento inicial deve ser feito conectado à internet. Verifique sua conexão e tente novamente.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Tentar novamente'));

      verify(() => employeeSearchCubit.init()).called(1);
    });

    testWidgets('show no response alert test', (tester) async {
      when(
        () => employeeSearchCubit.state,
      ).thenReturn(
        EmployeeSearchFailure(),
      );

      await tester.pumpWidget(widget);
      expect(find.text('Serviço sem resposta'), findsOneWidget);
      expect(
        find.text(
          'Não foi possivel estabelecer uma conexão com o serviço de marcação de ponto.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Tentar novamente'));

      verify(() => employeeSearchCubit.init()).called(1);
    });

      testWidgets('IconButton onPressed callback', (tester) async {
      when(
        () => employeeSearchCubit.state,
      ).thenReturn(
        EmployeeSearchSuccess(),
      );

      await tester.pumpWidget(widget);

      expect(find.byIcon(FontAwesomeIcons.magnifyingGlass), findsOneWidget);

      await tester.tap(find.byIcon(FontAwesomeIcons.magnifyingGlass));

      verify(() => employeeSearchCubit.search()).called(1);
    });

    testWidgets('IconAngleLeft onPressed callback', (tester) async {
      when(
        () => employeeSearchCubit.state,
      ).thenReturn(
        EmployeeSearchSuccess(),
      );

      await tester.pumpWidget(widget);

      expect(find.byIcon(FontAwesomeIcons.angleLeft), findsOneWidget);

      await tester.tap(find.byIcon(FontAwesomeIcons.angleLeft));
    });
  });
}
