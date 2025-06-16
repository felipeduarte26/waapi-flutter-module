import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/about/domain/presenter/cubit/about_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/about/domain/presenter/cubit/about_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/about/domain/presenter/screens/about_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

class MockAboutCubit extends Mock implements AboutCubit {}

class FakeBuildContext extends Fake implements BuildContext {}

class MockNavigatorService extends Fake implements NavigatorService {}

class FakeRoute extends Fake implements Route {}

void main() {
  late AboutCubit cubit;
  final BuildContext buildContext = FakeBuildContext();
  late NavigatorService navigatorService;

  Widget getWidget(Widget child, String locale) {
    return MaterialApp(
      home: Localizations(
        delegates: const [
          CollectorLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale(locale),
        child: SeniorDesignSystem(
          theme: SENIOR_LIGHT_THEME,
          child: child,
        ),
      ),
    );
  }

  setUp(() {
    cubit = MockAboutCubit();
    navigatorService = MockNavigatorService();

    registerFallbackValue(FakeRoute());
    registerFallbackValue(buildContext);

    when(() => cubit.state).thenReturn(ReadContentState());

    whenListen(
      cubit,
      Stream.fromIterable([ReadContentState()]),
    );

    when(() => cubit.loadData()).thenAnswer((_) async => {});

    when(() => cubit.version).thenAnswer((_) => '1');

    when(() => cubit.identifier).thenAnswer((_) => '123');

    when(() => cubit.model).thenAnswer((_) => 'motorola');

    when(() => cubit.name).thenAnswer((_) => 'moto g');
  });

  testWidgets('should initialize cubit on initState', (tester) async {
    Widget screen = getWidget(
      AboutScreen(
        cubit: cubit,
        navigatorService: navigatorService,
      ),
      'pt',
    );

    await tester.pumpWidget(screen);

    verify(() => cubit.loadData()).called(1);
  });

  testWidgets('should show loading widget when state is not ReadContentState',
      (tester) async {
    when(() => cubit.state).thenReturn(LoadingContentState());

    whenListen(
      cubit,
      Stream.fromIterable([LoadingContentState()]),
    );

    Widget screen = getWidget(
      AboutScreen(
        cubit: cubit,
        navigatorService: navigatorService,
      ),
      'pt',
    );

    await tester.pumpWidget(screen);

    expect(find.byType(LoadingWidget), findsOneWidget);
  });
}
