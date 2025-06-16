import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/cubit/mfa_authentication_code_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/widgets/mfa_authentication_request_config_content.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockMFAAuthenticationCubit extends MockCubit<MFAAuthenticationState>
    implements MFAAuthenticationCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late MFAAuthenticationCubit mfaAuthenticationCubit;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    mfaAuthenticationCubit = MockMFAAuthenticationCubit();
  });

  Widget makeTestableWidget({required bool redefine}) {
    return SeniorDesignSystem(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authenticationBloc,
          ),
          BlocProvider<MFAAuthenticationCubit>(
            create: (BuildContext context) => mfaAuthenticationCubit,
          ),
        ],
        child: BaseAuthenticationScreen(
          child: SeniorBackdrop(
            title: Builder(
                builder: (context) =>
                    Text(context.l10n.multifactorAuthentication)),
            body: MfaAuthenticationRequestConfigContent(redefine: redefine),
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly if not configured ', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state)
        .thenReturn(MFAAuthenticationState.initial().copyWith(
      status: NetworkStatus.idle,
    ));

    await tester.pumpWidget(makeTestableWidget(redefine: true));

    final welcomeMessageFinder = find.text(
      'Your MFA configuration has been reset by the administrator. Please set it up again.',
    );

    final btnFinderRequest = find.byWidgetPredicate((widget) =>
        widget is SeniorButton && widget.label == 'Request configuration');

    final btnFinderBack = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Back');

    expect(welcomeMessageFinder, findsOneWidget);
    expect(btnFinderRequest, findsOneWidget);
    expect(btnFinderBack, findsOneWidget);
  });

  testWidgets('should render correctly if need redefine configuration',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state)
        .thenReturn(MFAAuthenticationState.initial().copyWith(
      status: NetworkStatus.idle,
    ));

    await tester.pumpWidget(makeTestableWidget(redefine: false));

    final welcomeMessageFinder = find.text(
      'For your first access, you need to configure your user to perform two-factor authentication. The configuration must be done via email.',
    );

    final btnFinderRequest = find.byWidgetPredicate((widget) =>
        widget is SeniorButton && widget.label == 'Request configuration');

    final btnFinderBack = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Back');

    expect(welcomeMessageFinder, findsOneWidget);
    expect(btnFinderRequest, findsOneWidget);
    expect(btnFinderBack, findsOneWidget);
  });

  testWidgets('SeniorButton request config should perform tap correctly',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state)
        .thenReturn(MFAAuthenticationState.initial().copyWith(
      status: NetworkStatus.idle,
    ));

    when(() => mfaAuthenticationCubit.sendMFAConfigEmail(
          temporaryToken: 'temporaryToken',
          tenant: 'tenant',
        )).thenAnswer((_) {
      return;
    });

    await tester.pumpWidget(makeTestableWidget(redefine: false));

    final btnFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorButton && widget.label == 'Request configuration');

    await tester.tap(btnFinder, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(btnFinder, findsOneWidget);

    await mfaAuthenticationCubit.sendMFAConfigEmail(
      temporaryToken: 'temporaryToken',
      tenant: 'tenant',
    );

    verify(() => mfaAuthenticationCubit.sendMFAConfigEmail(
          temporaryToken: 'temporaryToken',
          tenant: 'tenant',
        )).called(1);
  });

  testWidgets('SeniorButton request config should return Snackbar with error',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state)
        .thenReturn(const MFAAuthenticationState(
      email: '',
      mfaInfo: MFAInfo(),
      mfaStatus: MFAAuthenticationStatus.notConfigured,
      status: NetworkStatus.idle,
    ));

    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    whenListen(
      mfaAuthenticationCubit,
      Stream<MFAAuthenticationState>.fromIterable([
        const MFAAuthenticationState(
          email: '',
          mfaInfo: MFAInfo(),
          mfaStatus: MFAAuthenticationStatus.notConfigured,
          status: NetworkStatus.idle,
        ),
        const MFAAuthenticationState(
          email: '',
          mfaInfo: MFAInfo(),
          mfaStatus: MFAAuthenticationStatus.notConfigured,
          status: NetworkStatus.idle,
          errorType: ErrorType.unauthorized,
        ),
      ]),
      initialState: const MFAAuthenticationState(
        email: '',
        mfaInfo: MFAInfo(),
        mfaStatus: MFAAuthenticationStatus.notConfigured,
        status: NetworkStatus.idle,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(redefine: false));

    final btnFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorButton && widget.label == 'Request configuration');

    await tester.tap(btnFinder, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(btnFinder, findsOneWidget);

    await expectLater(find.byType(SnackBar), findsOneWidget);
    await expectLater(find.text('unauthorized'), findsOneWidget);
  });
}
