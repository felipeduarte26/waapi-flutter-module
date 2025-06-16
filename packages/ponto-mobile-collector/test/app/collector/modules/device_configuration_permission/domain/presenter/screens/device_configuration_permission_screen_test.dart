import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/device_configuration_permission/domain/presenter/cubit/device_configuration_permission_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/device_configuration_permission/domain/presenter/cubit/device_configuration_permission_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/device_configuration_permission/domain/presenter/screens/device_configuration_permission_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

class MockDeviceConfigurationPermissionCubit extends Mock
    implements DeviceConfigurationPermissionCubit {}

class FakeBuildContext extends Fake implements BuildContext {}

class MockNavigatorService extends Fake implements NavigatorService {}

class FakeRoute extends Fake implements Route {}

void main() {
  late DeviceConfigurationPermissionCubit cubit;
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
    cubit = MockDeviceConfigurationPermissionCubit();
    navigatorService = MockNavigatorService();

    registerFallbackValue(FakeRoute());
    registerFallbackValue(buildContext);

    when(() => cubit.state).thenReturn(ReadContentState());

    whenListen(
      cubit,
      Stream.fromIterable([ReadContentState()]),
    );

    when(() => cubit.initialize()).thenAnswer((_) async => {});

    when(() => cubit.hasCameraPermission).thenAnswer((_) => true);

    when(() => cubit.hasGPSPermission).thenAnswer((_) => true);

    when(() => cubit.hasStoragePermission).thenAnswer((_) => true);

    when(() => cubit.hasNFCPermission).thenAnswer((_) => true);

    when(() => cubit.hasPhotosPermission).thenAnswer((_) => true);

    when(() => cubit.isMulti).thenAnswer((_) => true);

    //when(() => navigatorService.pop()).thenReturn(() {});
  });

  testWidgets('should initialize cubit on initState', (tester) async {
    Widget screen = getWidget(
      DeviceConfigurationPermissionScreen(
        cubit: cubit,
        navigatorService: navigatorService,
      ),
      'pt',
    );

    await tester.pumpWidget(screen);

    verify(() => cubit.initialize()).called(1);
  });
  
  testWidgets('should show loading widget when state is not ReadContentState',
      (tester) async {
    when(() => cubit.state).thenReturn(LoadingContentState());

    whenListen(
      cubit,
      Stream.fromIterable([LoadingContentState()]),
    );

    Widget screen = getWidget(
      DeviceConfigurationPermissionScreen(
        cubit: cubit,
        navigatorService: navigatorService,
      ),
      'pt',
    );

    await tester.pumpWidget(screen);

    expect(find.byType(LoadingWidget), findsOneWidget);
  });
}
