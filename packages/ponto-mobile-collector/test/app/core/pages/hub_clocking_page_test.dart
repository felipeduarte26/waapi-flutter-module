import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/hub_menu_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/hub_menu_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/hub_menu/hub_menu_widget.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockHubMenuCubit extends Mock implements HubMenuCubit {}

class MockSharedPreferencesService extends Mock implements SharedPreferencesService {}

class FakeBuildMenuState extends Fake implements BuildMenuState {}

class FakeHubMenuEntity extends Fake implements HubMenuEntity {}

void main() {
  late HubMenuCubit mockHubMenuCubit;
  late SharedPreferencesService mockSharedPreferencesService;

  setUpAll(() {
    HubMenuEntity entity = FakeHubMenuEntity();
    registerFallbackValue(entity);
  });

  setUp(() {
    Future<String?> employeeId = Future.value('2db0a8fd-85d1-4f3c-99ff-578f9091627e');

    HubMenuEntity entity = HubMenuEntity(onTap: () => null, title: 'Test', iconData: Icons.add);
    mockHubMenuCubit = MockHubMenuCubit();
    mockSharedPreferencesService = MockSharedPreferencesService();
    when(() => mockHubMenuCubit.state).thenReturn(InitialMenuState());
    when(() => mockHubMenuCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        InitialMenuState(),
        MenuChangedState(),
      ]),
    );
    when(() => mockSharedPreferencesService.getSessionEmployeeId()).thenAnswer((_) => employeeId);
    when(
      () => mockSharedPreferencesService.getUserPermission(
        userName: employeeId.toString(),
        action: UserActionEnum.allow.toString(),
        resource: UserResourceEnum.employee.resource,
      ),
    ).thenAnswer((_) => Future.value(false));
    when(() => mockHubMenuCubit.getTotalItems()).thenReturn(1);
    when(() => mockHubMenuCubit.getHubMenuEntity(0)).thenReturn(entity);
    when(
      () => mockHubMenuCubit.addPlatformMenus(
        driverTitle: any(named: 'driverTitle'),
        timeAdjustmentTitle: any(named: 'timeAdjustmentTitle'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockHubMenuCubit.addClockingEventMenu(any())).thenAnswer((_) async {});
    when(() => mockHubMenuCubit.addItem(any())).thenAnswer((invocation) {});
  });

  Widget getWidget(String locale, Widget widget, {bool isCustom = false}) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: isCustom
                ? SENIOR_LIGHT_THEME.copyWith(themeType: ThemeType.custom, primaryColor: Colors.red)
                : SENIOR_LIGHT_THEME,
            child: widget,
          ),
        ),
      ),
    );
  }

  testWidgets('hub clocking page ...', (tester) async {
    await tester.pumpWidget(
      getWidget(
        'pt',
        Builder(
          builder: (context) => HubClockingPage(
            hubMenuCubit: mockHubMenuCubit,
            context: context,
          ),
        ),
      ),
    );

    expect(find.byType(SeniorColorfulHeaderStructure), findsOneWidget);

    expect(find.byType(ListView), findsOneWidget);

    expect(find.byType(HubMenuWidget), findsOneWidget);

    expect(find.byType(SeniorCard), findsOneWidget);

    expect(
      find.text('Centralizando a jornada do colaborador'),
      findsOneWidget,
    );

    expect(
      find.text('Tenha o controle da sua jornada do ponto.'),
      findsOneWidget,
    );

    expect(
      find.text('Atalhos para o Gestão do Ponto'),
      findsOneWidget,
    );

    expect(
      find.text('Test'),
      findsOneWidget,
    );
  });

  testWidgets('hub clocking page with custom theme ...', (tester) async {
    await tester.pumpWidget(
      getWidget(
        'pt',
        Builder(
          builder: (context) => HubClockingPage(
            hubMenuCubit: mockHubMenuCubit,
            context: context,
          ),
        ),
        isCustom: true,
      ),
    );

    expect(find.byType(SeniorColorfulHeaderStructure), findsOneWidget);

    expect(find.byType(ListView), findsOneWidget);

    expect(find.byType(HubMenuWidget), findsOneWidget);

    expect(find.byType(SeniorCard), findsOneWidget);

    expect(
      find.text('Centralizando a jornada do colaborador'),
      findsOneWidget,
    );

    expect(
      find.text('Tenha o controle da sua jornada do ponto.'),
      findsOneWidget,
    );

    expect(
      find.text('Atalhos para o Gestão do Ponto'),
      findsOneWidget,
    );

    expect(
      find.text('Test'),
      findsOneWidget,
    );
  });
}
