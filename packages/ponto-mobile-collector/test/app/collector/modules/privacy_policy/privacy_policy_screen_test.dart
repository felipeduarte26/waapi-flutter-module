import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/privacy_policy_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/privacy_policy/domain/presenter/cubit/privacy_policy_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/privacy_policy/domain/presenter/cubit/privacy_policy_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/privacy_policy/domain/presenter/screens/privacy_policy_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

class MockPrivacyPolicyCubit extends Mock implements PrivacyPolicyCubit {}

class MockNavigatorService extends Mock implements NavigatorService {}

class FakeRoute extends Fake implements Route {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late PrivacyPolicyCubit cubit;
  late NavigatorService navigatorService;
  final BuildContext buildContext = FakeBuildContext();

  PrivacyPolicyEntity privacyPolicyMock = PrivacyPolicyEntity(
    dateTimeEventRead: DateTime.now(),
    urlVersion: 'https://www.google.com',
    version: 1,
  );

  Widget createWidgetUnderTest(Widget child, String locale) {
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
    cubit = MockPrivacyPolicyCubit();
    navigatorService = MockNavigatorService();

    registerFallbackValue(FakeRoute());
    registerFallbackValue(buildContext);

    // Configurações padrão do cubit
    when(() => cubit.state).thenReturn(
      ReadContentState(
        dateTimeEventRead: '',
        privacyPolicyEntity: privacyPolicyMock,
      ),
    );
    whenListen(
      cubit,
      Stream.fromIterable(
        [
          ReadContentState(
            dateTimeEventRead: '',
            privacyPolicyEntity: privacyPolicyMock,
          ),
        ],
      ),
    );

    // Configuração de métodos do cubit
    when(() => cubit.initialize()).thenAnswer((_) async => {});
    when(
      () => cubit.goToPrivacyPolicyPage(
        lastVersionSaved: privacyPolicyMock,
      ),
    ).thenAnswer((_) async {});
  });

  testWidgets('deve inicializar o cubit ao carregar a tela', (tester) async {
    await tester.pumpWidget(
      createWidgetUnderTest(
        PrivacyPolicyScreen(cubit: cubit, navigatorService: navigatorService),
        'pt',
      ),
    );

    verify(() => cubit.initialize()).called(1);
  });

  testWidgets(
      'deve exibir LoadingWidget quando o estado for LoadingContentState',
      (tester) async {
    when(() => cubit.state).thenReturn(LoadingContentState());
    whenListen(cubit, Stream.fromIterable([LoadingContentState()]));

    await tester.pumpWidget(
      createWidgetUnderTest(
        PrivacyPolicyScreen(cubit: cubit, navigatorService: navigatorService),
        'pt',
      ),
    );

    expect(find.byType(LoadingWidget), findsOneWidget);
  });

  testWidgets(
      'deve exibir a mensagem e o botão de reconexão quando o estado for HasNoConnectionState',
      (tester) async {
    when(() => cubit.state).thenReturn(HasNoConectionState());
    whenListen(cubit, Stream.fromIterable([HasNoConectionState()]));

    await tester.pumpWidget(
      createWidgetUnderTest(
        PrivacyPolicyScreen(cubit: cubit, navigatorService: navigatorService),
        'pt',
      ),
    );

    expect(find.byIcon(FontAwesomeIcons.circleExclamation), findsOneWidget);
    expect(
      find.text(
        CollectorLocalizations.of(
          tester.element(find.byType(PrivacyPolicyScreen)),
        ).facialLooksLikeAreOffline,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        CollectorLocalizations.of(
          tester.element(find.byType(PrivacyPolicyScreen)),
        ).facialTryAgain,
      ),
      findsOneWidget,
    );
  });

  testWidgets(
      'deve chamar initialize novamente quando o botão "Tentar Novamente" for pressionado',
      (tester) async {
    when(() => cubit.state).thenReturn(HasNoConectionState());
    whenListen(cubit, Stream.fromIterable([HasNoConectionState()]));

    await tester.pumpWidget(
      createWidgetUnderTest(
        PrivacyPolicyScreen(cubit: cubit, navigatorService: navigatorService),
        'pt',
      ),
    );

    await tester.tap(
      find.text(
        CollectorLocalizations.of(
          tester.element(find.byType(PrivacyPolicyScreen)),
        ).facialTryAgain,
      ),
    );
    await tester.pump();

    verify(() => cubit.initialize()).called(2);
  });

  testWidgets(
      'deve exibir o conteúdo da política de privacidade quando o estado for ReadContentState',
      (tester) async {
    when(() => cubit.state).thenReturn(
      ReadContentState(
        dateTimeEventRead: '',
        privacyPolicyEntity: privacyPolicyMock,
      ),
    );

    await tester.pumpWidget(
      createWidgetUnderTest(
        PrivacyPolicyScreen(cubit: cubit, navigatorService: navigatorService),
        'pt',
      ),
    );

    expect(
      find.text(
        CollectorLocalizations.of(
          tester.element(
            find.byType(PrivacyPolicyScreen),
          ),
        ).privacyPolicies,
      ),
      findsOneWidget,
    );
  });

  testWidgets(
      'deve chamar goToPrivacyPolicyPage ao clicar no conteúdo da política de privacidade',
      (tester) async {
    final state = ReadContentState(
      dateTimeEventRead: '',
      privacyPolicyEntity: privacyPolicyMock,
    );
    when(() => cubit.state).thenReturn(state);

    await tester.pumpWidget(
      createWidgetUnderTest(
        PrivacyPolicyScreen(cubit: cubit, navigatorService: navigatorService),
        'pt',
      ),
    );

    await tester.tap(
      find.descendant(
        of: find.byType(PrivacyPolicyScreen),
        matching: find.text('Política de privacidade').last,
      ),
    );
    await tester.pump();

    verify(
      () => cubit.goToPrivacyPolicyPage(
        lastVersionSaved: state.privacyPolicyEntity,
      ),
    ).called(1);
  });
}
