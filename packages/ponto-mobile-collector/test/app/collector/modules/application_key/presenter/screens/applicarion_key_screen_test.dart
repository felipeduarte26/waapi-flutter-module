import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/cubit/application_key_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/cubit/application_key_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/screens/applicarion_key_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../mocks/token_mock.dart';

class MockNavigatorService extends Mock implements NavigatorService {}

class FakeRoute extends Fake implements Route {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {
  void emitState(AuthenticationState state) {
    super.emit(state);
  }
}

class MockApplicationKeyCubit
    extends MockBloc<ApplicationKeyCubit, ApplicationKeyBaseState>
    implements ApplicationKeyCubit {}

void main() {
  late ApplicationKeyCubit mockApplicationKeyCubit;
  late MockAuthenticationBloc mockAuthenticationBloc;
  late NavigatorService navigatorService;
  const String tAccessKey = 'tAccessKey';
  const String baseString = 'AuthenticationKey';
  const Widget userNameAuthenticationScreen =
      Text('userNameAuthenticationScreen');

  AuthenticationState authenticationState = AuthenticationState.authenticated(
    token: tokenMock,
    keyToken: tokenMock,
  );

  Widget getWidget(Widget child, String locale) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: child,
        ),
      ),
    );
  }

  setUp(() {
    mockApplicationKeyCubit = MockApplicationKeyCubit();
    mockAuthenticationBloc = MockAuthenticationBloc();
    navigatorService = MockNavigatorService();

    when(
      () => mockApplicationKeyCubit.loadContent(),
    ).thenAnswer((_) async => {});

    when(
      () => mockApplicationKeyCubit.logoffUser(),
    ).thenAnswer((_) async => {});

    when(
      () => mockAuthenticationBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([]));
  });

  group('ApplicationKeyScreen', () {
    testWidgets(
      'Show no connectivity test',
      (tester) async {
        registerFallbackValue(FakeRoute());

        when(
          () => mockAuthenticationBloc.state,
        ).thenReturn(const AuthenticationState.unauthenticated());

        when(
          () => mockApplicationKeyCubit.state,
        ).thenReturn(HasNoConnectivityState());

        whenListen(
          mockAuthenticationBloc,
          Stream.fromIterable([
            const AuthenticationState.unauthenticated(),
            const AuthenticationState.offline(tAccessKey),
            const AuthenticationState.unknown(),
            const AuthenticationState.authenticated(),
          ]),
        );

        Widget widget = getWidget(
          ApplicationKeyScreen(
            content: const Text(baseString),
            authenticationBloc: mockAuthenticationBloc,
            applicationKeyCubit: mockApplicationKeyCubit,
            userNameAuthenticationScreen: userNameAuthenticationScreen,
            homePath: '',
            navigatorService: navigatorService,
          ),
          'pt',
        );

        await tester.pumpWidget(widget);
      },
    );

    testWidgets(
      'Show user without permission test',
      (tester) async {
        registerFallbackValue(FakeRoute());

        when(
          () => mockAuthenticationBloc.state,
        ).thenReturn(const AuthenticationState.unauthenticated());

        when(
          () => mockApplicationKeyCubit.state,
        ).thenReturn(UserWithoutPermissionState());

        whenListen(
          mockAuthenticationBloc,
          Stream.fromIterable([
            const AuthenticationState.unauthenticated(),
            const AuthenticationState.offline(tAccessKey),
            const AuthenticationState.unknown(),
            const AuthenticationState.authenticated(),
          ]),
        );

        Widget widget = getWidget(
          ApplicationKeyScreen(
            content: const Text(baseString),
            authenticationBloc: mockAuthenticationBloc,
            applicationKeyCubit: mockApplicationKeyCubit,
            userNameAuthenticationScreen: userNameAuthenticationScreen,
            homePath: '',
            navigatorService: navigatorService,
          ),
          'pt',
        );

        await tester.pumpWidget(widget);

        final backToHomeButtonFinder = find.text(
          'Voltar',
        );

        await tester.tap(backToHomeButtonFinder);
      },
    );

    testWidgets(
      'Show screen loading test',
      (tester) async {
        registerFallbackValue(FakeRoute());

        when(
          () => mockAuthenticationBloc.state,
        ).thenReturn(const AuthenticationState.unauthenticated());

        when(
          () => mockApplicationKeyCubit.state,
        ).thenReturn(LoadingUserIsAuthenticatedState());

        whenListen(
          mockAuthenticationBloc,
          Stream.fromIterable([
            const AuthenticationState.unauthenticated(),
            const AuthenticationState.offline(tAccessKey),
            const AuthenticationState.unknown(),
            authenticationState,
          ]),
        );

        Widget widget = getWidget(
          ApplicationKeyScreen(
            content: const Text(baseString),
            authenticationBloc: mockAuthenticationBloc,
            applicationKeyCubit: mockApplicationKeyCubit,
            userNameAuthenticationScreen: userNameAuthenticationScreen,
            homePath: '',
            navigatorService: navigatorService,
          ),
          'pt',
        );

        await tester.pumpWidget(widget);

        expect(
          find.widgetWithText(
            LoadingWidget,
            'Carregando...',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Show screen ReadContentSetKeyState test',
      (tester) async {
        registerFallbackValue(FakeRoute());

        when(
          () => mockAuthenticationBloc.state,
        ).thenReturn(const AuthenticationState.authenticated());

        when(
          () => mockApplicationKeyCubit.state,
        ).thenReturn(ReadContentSetKeyState());

        whenListen(
          mockAuthenticationBloc,
          Stream.fromIterable([
            const AuthenticationState.unauthenticated(),
            const AuthenticationState.offline(tAccessKey),
            const AuthenticationState.unknown(),
            authenticationState,
          ]),
        );

        Widget widget = getWidget(
          ApplicationKeyScreen(
            content: const Text(baseString),
            authenticationBloc: mockAuthenticationBloc,
            applicationKeyCubit: mockApplicationKeyCubit,
            userNameAuthenticationScreen: userNameAuthenticationScreen,
            homePath: '',
            navigatorService: navigatorService,
          ),
          'pt',
        );

        await tester.pumpWidget(widget);
      },
    );

    testWidgets(
      'Show screen KeyAlreadyRegistered test',
      (tester) async {
        registerFallbackValue(FakeRoute());

        when(
          () => mockAuthenticationBloc.state,
        ).thenReturn(const AuthenticationState.authenticated());

        when(
          () => mockApplicationKeyCubit.state,
        ).thenReturn(KeyAlreadyRegisteredState());

        whenListen(
          mockAuthenticationBloc,
          Stream.fromIterable([
            const AuthenticationState.unauthenticated(),
            const AuthenticationState.offline(tAccessKey),
            const AuthenticationState.unknown(),
            authenticationState,
          ]),
        );

        Widget widget = getWidget(
          ApplicationKeyScreen(
            content: const Text(baseString),
            authenticationBloc: mockAuthenticationBloc,
            applicationKeyCubit: mockApplicationKeyCubit,
            userNameAuthenticationScreen: userNameAuthenticationScreen,
            homePath: '',
            navigatorService: navigatorService,
          ),
          'pt',
        );

        await tester.pumpWidget(widget);

        expect(
          find.text(
            'Você pode remover a chave com a ação abaixo.',
          ),
          findsOneWidget,
        );

        final removeKeyButtonFinder = find.text(
          'Remover chave',
        );

        await tester.tap(removeKeyButtonFinder);
      },
    );

    testWidgets(
      'Show screen KeyRegisteredSuccessfully test',
      (tester) async {
        registerFallbackValue(FakeRoute());

        when(
          () => mockAuthenticationBloc.state,
        ).thenReturn(const AuthenticationState.authenticated());

        when(
          () => mockApplicationKeyCubit.state,
        ).thenReturn(KeyRegisteredSuccessfullyState());

        when(
          () => navigatorService.popAndPushNamed(
            route: any(named: 'route'),
          ),
        ).thenAnswer((_) async => true);

        whenListen(
          mockAuthenticationBloc,
          Stream.fromIterable([
            const AuthenticationState.unauthenticated(),
            const AuthenticationState.offline(tAccessKey),
            const AuthenticationState.unknown(),
            authenticationState,
          ]),
        );

        Widget widget = getWidget(
          ApplicationKeyScreen(
            content: const Text(baseString),
            authenticationBloc: mockAuthenticationBloc,
            applicationKeyCubit: mockApplicationKeyCubit,
            userNameAuthenticationScreen: userNameAuthenticationScreen,
            homePath: '',
            navigatorService: navigatorService,
          ),
          'pt',
        );

        await tester.pumpWidget(widget);

        final backToHomeButton = find.text(
          'Voltar ao início',
        );

        expect(
          backToHomeButton,
          findsOneWidget,
        );

        await tester.tap(backToHomeButton);
      },
    );

    testWidgets(
        'Show authentication screen when user is not authenticated test',
        (tester) async {
      when(
        () => mockAuthenticationBloc.state,
      ).thenReturn(const AuthenticationState.unauthenticated());

      when(
        () => mockAuthenticationBloc.stream,
      ).thenAnswer(
        (_) => Stream.fromIterable([const AuthenticationState.authenticated()]),
      );

      when(
        () => mockApplicationKeyCubit.state,
      ).thenReturn(UserNotAuthenticatedState());

      Widget widget = getWidget(
        ApplicationKeyScreen(
          content: const Text(baseString),
          authenticationBloc: mockAuthenticationBloc,
          applicationKeyCubit: mockApplicationKeyCubit,
          userNameAuthenticationScreen: userNameAuthenticationScreen,
          homePath: '',
          navigatorService: navigatorService,
        ),
        'pt',
      );

      await tester.pumpWidget(widget);
      expect(find.text('userNameAuthenticationScreen'), findsOneWidget);
    });

    testWidgets('call loadContent after user authenticates test',
        (tester) async {
      when(
        () => mockAuthenticationBloc.state,
      ).thenReturn(const AuthenticationState.unauthenticated());

      when(
        () => mockApplicationKeyCubit.state,
      ).thenReturn(UserNotAuthenticatedState());

      when(
        () => mockAuthenticationBloc.stream,
      ).thenAnswer(
        (_) => Stream.fromIterable([const AuthenticationState.authenticated()]),
      );

      Widget widget = getWidget(
        ApplicationKeyScreen(
          content: const Text(baseString),
          authenticationBloc: mockAuthenticationBloc,
          applicationKeyCubit: mockApplicationKeyCubit,
          userNameAuthenticationScreen: userNameAuthenticationScreen,
          homePath: '',
          navigatorService: navigatorService,
        ),
        'pt',
      );

      await tester.pumpWidget(widget);
      await tester.pump(const Duration(seconds: 1));
      verifyNever(() => mockApplicationKeyCubit.logoffUser());
    });

    testWidgets(
      'Loading message when state is VerifyingUnsycedClockingEventsState',
      (tester) async {
        const locale = Locale('pt');
        final collectorLocalizations = lookupCollectorLocalizations(locale);

        when(
          () => mockAuthenticationBloc.state,
        ).thenReturn(authenticationState);

        when(
          () => mockApplicationKeyCubit.state,
        ).thenReturn(VerifyingUnsycedClockingEventsState());

        Widget widget = getWidget(
          ApplicationKeyScreen(
            content: const Text(baseString),
            authenticationBloc: mockAuthenticationBloc,
            applicationKeyCubit: mockApplicationKeyCubit,
            userNameAuthenticationScreen: userNameAuthenticationScreen,
            homePath: '',
            navigatorService: navigatorService,
          ),
          locale.languageCode,
        );

        await tester.pumpWidget(widget);

        expect(
          find.text(
            collectorLocalizations.loadingUnsyncedClockingEvents,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Loading message when state is RemovingKeysState',
      (tester) async {
        const locale = Locale('pt');
        final collectorLocalizations = lookupCollectorLocalizations(locale);

        when(
          () => mockAuthenticationBloc.state,
        ).thenReturn(authenticationState);

        when(
          () => mockApplicationKeyCubit.state,
        ).thenReturn(RemovingKeysState());

        Widget widget = getWidget(
          ApplicationKeyScreen(
            content: const Text(baseString),
            authenticationBloc: mockAuthenticationBloc,
            applicationKeyCubit: mockApplicationKeyCubit,
            userNameAuthenticationScreen: userNameAuthenticationScreen,
            homePath: '',
            navigatorService: navigatorService,
          ),
          locale.languageCode,
        );

        await tester.pumpWidget(widget);

        expect(
          find.text(
            collectorLocalizations.removingKeys,
          ),
          findsOneWidget,
        );
      },
    );
  });

  group(
    'PopScope',
    () {
      testWidgets(
        'onPopInvoked',
        (tester) async {
          when(
            () => mockAuthenticationBloc.state,
          ).thenReturn(const AuthenticationState.unauthenticated());

          when(
            () => mockApplicationKeyCubit.state,
          ).thenReturn(UserNotAuthenticatedState());

          Widget widget = getWidget(
            ApplicationKeyScreen(
              content: const Text(baseString),
              authenticationBloc: mockAuthenticationBloc,
              applicationKeyCubit: mockApplicationKeyCubit,
              userNameAuthenticationScreen: userNameAuthenticationScreen,
              homePath: '',
              navigatorService: navigatorService,
            ),
            'pt',
          );

          await tester.pumpWidget(widget);

          final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
          await widgetsAppState.didPopRoute();

          verify(
            () => navigatorService.pop(),
          ).called(1);
          verifyNever(
            () => navigatorService.popAndPushNamed(
              route: any(named: 'route'),
            ),
          );
        },
      );

      testWidgets(
        'onPopInvoked and state is KeyRegisteredSuccessfullyState',
        (tester) async {
          when(
            () => mockAuthenticationBloc.state,
          ).thenReturn(authenticationState);

          when(
            () => mockApplicationKeyCubit.state,
          ).thenReturn(KeyRegisteredSuccessfullyState());

          when(
            () => navigatorService.popAndPushNamed(
              route: any(named: 'route'),
            ),
          ).thenAnswer((_) async => true);

          Widget widget = getWidget(
            ApplicationKeyScreen(
              content: const Text(baseString),
              authenticationBloc: mockAuthenticationBloc,
              applicationKeyCubit: mockApplicationKeyCubit,
              userNameAuthenticationScreen: userNameAuthenticationScreen,
              homePath: '',
              navigatorService: navigatorService,
            ),
            'pt',
          );

          await tester.pumpWidget(widget);

          final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
          await widgetsAppState.didPopRoute();

          verify(
            () => navigatorService.popAndPushNamed(
              route: any(named: 'route'),
            ),
          ).called(1);

          verifyNever(
            () => navigatorService.pop(),
          );
        },
      );
    },
  );

  group(
    'Dialogs',
    () {
      testWidgets(
        'Confirm remove keys (yes option)',
        (tester) async {
          const locale = Locale('pt');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          whenListen(
            mockApplicationKeyCubit,
            Stream.fromIterable([
              ConfirmRemoveKeysState(),
            ]),
            initialState: KeyAlreadyRegisteredState(),
          );

          Widget widget = getWidget(
            ApplicationKeyScreen(
              content: const Text(baseString),
              authenticationBloc: mockAuthenticationBloc,
              applicationKeyCubit: mockApplicationKeyCubit,
              userNameAuthenticationScreen: userNameAuthenticationScreen,
              homePath: '',
              navigatorService: navigatorService,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.keyAlreadyRegisteredRemove,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.confirmRemoveKeys,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.no,
            ),
            findsOneWidget,
          );

          final yesButton = find.text(
            collectorLocalizations.yes,
          );

          expect(
            yesButton,
            findsOneWidget,
          );

          await tester.tap(yesButton);

          verify(
            () => mockApplicationKeyCubit.removeKeys(),
          ).called(1);

          verify(
            () => navigatorService.pop(value: true),
          ).called(1);

          verifyNever(
            () => navigatorService.pop(value: false),
          );

          verifyNever(
            () => mockApplicationKeyCubit.cancelRemoveKeys(),
          );
        },
      );

      testWidgets(
        'Confirm remove keys (no option)',
        (tester) async {
          const locale = Locale('pt');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          whenListen(
            mockApplicationKeyCubit,
            Stream.fromIterable([
              ConfirmRemoveKeysState(),
            ]),
            initialState: KeyAlreadyRegisteredState(),
          );

          Widget widget = getWidget(
            ApplicationKeyScreen(
              content: const Text(baseString),
              authenticationBloc: mockAuthenticationBloc,
              applicationKeyCubit: mockApplicationKeyCubit,
              userNameAuthenticationScreen: userNameAuthenticationScreen,
              homePath: '',
              navigatorService: navigatorService,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.keyAlreadyRegisteredRemove,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.confirmRemoveKeys,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.yes,
            ),
            findsOneWidget,
          );

          final noButton = find.text(
            collectorLocalizations.no,
          );

          expect(
            noButton,
            findsOneWidget,
          );

          await tester.tap(noButton);

          verify(
            () => navigatorService.pop(value: false),
          ).called(1);

          verifyNever(
            () => mockApplicationKeyCubit.removeKeys(),
          );
        },
      );

      testWidgets(
        'Has unsynced clocking events',
        (tester) async {
          const locale = Locale('pt');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          whenListen(
            mockApplicationKeyCubit,
            Stream.fromIterable([
              HasUnsyncedClockingEventsState(),
            ]),
            initialState: KeyAlreadyRegisteredState(),
          );

          Widget widget = getWidget(
            ApplicationKeyScreen(
              content: const Text(baseString),
              authenticationBloc: mockAuthenticationBloc,
              applicationKeyCubit: mockApplicationKeyCubit,
              userNameAuthenticationScreen: userNameAuthenticationScreen,
              homePath: '',
              navigatorService: navigatorService,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.unsyncedClockingEvents,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.syncClockingEventsBeforeRemoveKeys,
            ),
            findsOneWidget,
          );

          final closeButton = find.text(
            collectorLocalizations.close,
          );

          expect(
            closeButton,
            findsOneWidget,
          );

          await tester.tap(closeButton);

          verify(
            () => navigatorService.pop(),
          ).called(1);
        },
      );

      testWidgets(
        'Remove key error',
        (tester) async {
          const locale = Locale('pt');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          whenListen(
            mockApplicationKeyCubit,
            Stream.fromIterable([
              RemoveKeyErrorState(),
            ]),
            initialState: KeyAlreadyRegisteredState(),
          );

          Widget widget = getWidget(
            ApplicationKeyScreen(
              content: const Text(baseString),
              authenticationBloc: mockAuthenticationBloc,
              applicationKeyCubit: mockApplicationKeyCubit,
              userNameAuthenticationScreen: userNameAuthenticationScreen,
              homePath: '',
              navigatorService: navigatorService,
            ),
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.keysNotRemoved,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.keysRemovedUnsuccessfully,
            ),
            findsOneWidget,
          );

          final closeButton = find.text(
            collectorLocalizations.close,
          );

          expect(
            closeButton,
            findsOneWidget,
          );

          await tester.tap(closeButton);
          await tester.pump();

          verify(
            () => navigatorService.pop(),
          ).called(1);
        },
      );
    },
  );

  group(
    'Bloc Listener',
    () {
      testWidgets(
        'Keys removed',
        (tester) async {
          whenListen(
            mockApplicationKeyCubit,
            Stream.fromIterable([
              KeysRemovedState(),
            ]),
            initialState: KeyAlreadyRegisteredState(),
          );

          Widget widget = getWidget(
            ApplicationKeyScreen(
              content: const Text(baseString),
              authenticationBloc: mockAuthenticationBloc,
              applicationKeyCubit: mockApplicationKeyCubit,
              userNameAuthenticationScreen: userNameAuthenticationScreen,
              homePath: '',
              navigatorService: navigatorService,
            ),
            'pt',
          );

          await tester.pumpWidget(widget);

          verify(
            () => navigatorService.navigate(
              route: '',
            ),
          ).called(1);
        },
      );
    },
  );
}
