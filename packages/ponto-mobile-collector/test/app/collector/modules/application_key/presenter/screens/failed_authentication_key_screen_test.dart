import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/cubit/failed_authentication_key_cubit/failed_authentication_key_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/cubit/failed_authentication_key_cubit/failed_authentication_key_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/screens/failed_authentication_key_screen.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations_pt.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockFailedAuthenticationKeyCubit extends Mock
    implements FailedAuthenticationKeyCubit {}

void main() {
  final CollectorLocalizationsPt localizationsPt = CollectorLocalizationsPt();
  late FailedAuthenticationKeyCubit failedAuthenticationKeyCubit;

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
    failedAuthenticationKeyCubit = MockFailedAuthenticationKeyCubit();
    when(() => failedAuthenticationKeyCubit.state)
        .thenReturn(ReadyFailedAuthenticationKeyState());

    when(() => failedAuthenticationKeyCubit.stream).thenAnswer(
      (_) => Stream<FailedAuthenticationKeyBaseState>.fromIterable([]),
    );
  });

  group('FailedAuthenticationKeyScreen', () {
    testWidgets('show authetication in progress screen test', (tester) async {
      when(() => failedAuthenticationKeyCubit.state)
          .thenReturn(AuthenticatingFailedAuthenticationKeyState());

      await tester.pumpWidget(
        getWidget(
          FailedAuthenticationKeyScreen(
            failedAuthenticationKeyCubit: failedAuthenticationKeyCubit,
          ),
          'pt',
        ),
      );

      expect(find.text(localizationsPt.authenticating), findsOneWidget);
    });

    testWidgets('show screen options test', (tester) async {
      when(
        () => failedAuthenticationKeyCubit.authenticateKey(),
      ).thenAnswer((_) async => {});

      when(
        () => failedAuthenticationKeyCubit.navigateToRegisterKey(),
      ).thenAnswer((_) async => {});

      when(
        () => failedAuthenticationKeyCubit.closeApplication(),
      ).thenAnswer((_) async => {});

      await tester.pumpWidget(
        getWidget(
          FailedAuthenticationKeyScreen(
            failedAuthenticationKeyCubit: failedAuthenticationKeyCubit,
          ),
          'pt',
        ),
      );

      Finder facialTryAgain = find.text(localizationsPt.facialTryAgain);
      Finder reRegisterApplicationKey =
          find.text(localizationsPt.reRegisterApplicationKey);
      Finder goToLogin = find.text(localizationsPt.goToLogin);

      await tester.tap(facialTryAgain);
      await tester.tap(reRegisterApplicationKey);
      await tester.tap(goToLogin);

      expect(find.text(localizationsPt.authenticationFailure), findsOneWidget);
      expect(
        find.text(localizationsPt.errorWhileAuthenticatingApplicationKey),
        findsOneWidget,
      );
      expect(facialTryAgain, findsOneWidget);
      expect(reRegisterApplicationKey, findsOneWidget);
      expect(goToLogin, findsOneWidget);

      verify(() => failedAuthenticationKeyCubit.authenticateKey());
      verify(() => failedAuthenticationKeyCubit.navigateToRegisterKey());
      verify(() => failedAuthenticationKeyCubit.closeApplication());
    });

    testWidgets('show erro on authentication message test', (tester) async {
      whenListen(
        failedAuthenticationKeyCubit,
        Stream.fromIterable([
          FailureFailedAuthenticationKeyState(),
        ]),
      );

      await tester.pumpWidget(
        getWidget(
          FailedAuthenticationKeyScreen(
            failedAuthenticationKeyCubit: failedAuthenticationKeyCubit,
          ),
          'pt',
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text(localizationsPt.errorAuthenticatingApplicationKey),
        findsOneWidget,
      );
    });

    testWidgets('show no connection message test', (tester) async {
      whenListen(
        failedAuthenticationKeyCubit,
        Stream.fromIterable([
          NoConnectionFailedAuthenticationKeyState(),
        ]),
      );

      await tester.pumpWidget(
        getWidget(
          FailedAuthenticationKeyScreen(
            failedAuthenticationKeyCubit: failedAuthenticationKeyCubit,
          ),
          'pt',
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text(localizationsPt.facialLooksLikeAreOffline),
        findsOneWidget,
      );
    });
  });
}
