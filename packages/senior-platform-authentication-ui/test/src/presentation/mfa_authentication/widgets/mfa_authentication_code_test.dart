import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/cubit/mfa_authentication_code_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/widgets/mfa_authentication_code.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/reset_password_screen.dart';

import '../../../../mocks/clipboard_mock.dart';
import '../../../../mocks/mfa_info_mock.dart';
import '../../../../mocks/reset_password_mock.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockMFAAuthenticationCodeCubit extends MockCubit<MFAAuthenticationState>
    implements MFAAuthenticationCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late MFAAuthenticationCubit mfaAuthenticationCubit;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    mfaAuthenticationCubit = MockMFAAuthenticationCodeCubit();
  });

  Widget makeTestableWidget() {
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
              builder: (context) => Text(context.l10n.authenticationCode),
            ),
            body: const MFAAuthenticationCode(
              mfaInfo: mfaInfoConfiguredMock,
              username: 'username',
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('should render MFAAuthenticationCode', (tester) async {
    when(() => authenticationBloc.state).thenReturn(
      const AuthenticationState.unauthenticated(),
    );

    when(() => mfaAuthenticationCubit.state).thenReturn(
      MFAAuthenticationState.initial().copyWith(
          mfaInfo: mfaInfoConfiguredMock,
          mfaStatus: MFAAuthenticationStatus.configured,
          status: NetworkStatus.idle),
    );

    await tester.pumpWidget(makeTestableWidget());

    await tester.pumpAndSettle();
    final pinCodeFieldsFinder = find.byType(SeniorPinCodeFields);

    final insertAuthenticationCodeMessage = find.text('Enter the 6-digit code');
    final insertAuthenticationCodeMessageBody = find
        .text('The code can be obtained on your authenticator application.');

    expect(insertAuthenticationCodeMessageBody, findsOneWidget);
    expect(insertAuthenticationCodeMessage, findsOneWidget);
    expect(pinCodeFieldsFinder, findsOneWidget);
  });

  testWidgets('When complete pin code should perform login correctly',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state).thenReturn(
      MFAAuthenticationState.initial().copyWith(
          mfaInfo: mfaInfoConfiguredMock,
          mfaStatus: MFAAuthenticationStatus.configured,
          status: NetworkStatus.idle),
    );

    when(
      () => mfaAuthenticationCubit.login(
        temporaryToken: 'temporaryToken',
        tenant: 'tenant',
        validationCode: '123456',
      ),
    ).thenAnswer((_) async {
      return true;
    });

    await tester.pumpWidget(makeTestableWidget());

    final seniorPinCodeFields = find.byWidgetPredicate(
      (widget) =>
          widget is SeniorPinCodeFields &&
          widget.length == 6 &&
          widget.keyboardType == TextInputType.number,
    );

    await tester.enterText(
      seniorPinCodeFields,
      '123456',
    );

    verify(() => mfaAuthenticationCubit.login(
          temporaryToken: 'temporaryToken',
          tenant: 'tenant',
          validationCode: '123456',
        )).called(1);
  });

  testWidgets(
      'Should navigate to ResetPasswordScreen when resetpasswordInfo exists',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state)
        .thenReturn(const MFAAuthenticationState(
      email: '',
      mfaInfo: mfaInfoConfiguredMock,
      mfaStatus: MFAAuthenticationStatus.configured,
      status: NetworkStatus.idle,
      username: 'username',
    ));

    when(
      () => mfaAuthenticationCubit.login(
        validationCode: any(named: 'validationCode'),
        tenant: any(named: 'tenant'),
        temporaryToken: any(
          named: 'temporaryToken',
        ),
      ),
    ).thenAnswer(
      (_) async => true,
    );

    whenListen(
      mfaAuthenticationCubit,
      Stream<MFAAuthenticationState>.fromIterable([
        const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.loading,
            authenticationResponse: AuthenticationResponse(
              resetPasswordInfo: resetPasswordInfoMock,
            )),
      ]),
      initialState: const MFAAuthenticationState(
        email: '',
        mfaInfo: MFAInfo(),
        mfaStatus: MFAAuthenticationStatus.configured,
        status: NetworkStatus.idle,
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    final seniorPinCodeFields = find.byWidgetPredicate(
      (widget) =>
          widget is SeniorPinCodeFields &&
          widget.length == 6 &&
          widget.keyboardType == TextInputType.number,
    );

    await tester.enterText(
      seniorPinCodeFields,
      '123456',
    );
    await tester.pumpAndSettle();

    await expectLater(find.byType(ResetPasswordScreen), findsOneWidget);
    final resetPasswordScreen =
        tester.widget<ResetPasswordScreen>(find.byType(ResetPasswordScreen));
    expect(resetPasswordScreen.resetPasswordInfo, resetPasswordInfoMock);
  });

  testWidgets(
      'When complete pin code with UnauthorizedException'
      ' should return Snackbar with unauthorized error ', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state)
        .thenReturn(const MFAAuthenticationState(
      email: '',
      mfaInfo: MFAInfo(),
      mfaStatus: MFAAuthenticationStatus.configured,
      status: NetworkStatus.idle,
    ));

    when(
      () => mfaAuthenticationCubit.login(
        validationCode: any(named: 'validationCode'),
        tenant: any(named: 'tenant'),
        temporaryToken: any(
          named: 'temporaryToken',
        ),
      ),
    ).thenAnswer(
      (_) async => true,
    );

    whenListen(
      mfaAuthenticationCubit,
      Stream<MFAAuthenticationState>.fromIterable([
        const MFAAuthenticationState(
          email: '',
          mfaInfo: MFAInfo(),
          mfaStatus: MFAAuthenticationStatus.configured,
          status: NetworkStatus.idle,
        ),
        const MFAAuthenticationState(
          email: '',
          mfaInfo: MFAInfo(),
          mfaStatus: MFAAuthenticationStatus.configured,
          status: NetworkStatus.idle,
          errorType: ErrorType.unauthorized,
        ),
      ]),
      initialState: const MFAAuthenticationState(
        email: '',
        mfaInfo: MFAInfo(),
        mfaStatus: MFAAuthenticationStatus.configured,
        status: NetworkStatus.idle,
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    final seniorPinCodeFields = find.byWidgetPredicate(
      (widget) =>
          widget is SeniorPinCodeFields &&
          widget.length == 6 &&
          widget.keyboardType == TextInputType.number,
    );

    await tester.enterText(
      seniorPinCodeFields,
      '123456',
    );
    await tester.pumpAndSettle();

    await expectLater(find.byType(SnackBar), findsOneWidget);
    await expectLater(
        find.text('The entered code is invalid or expired. Please try again.'),
        findsOneWidget);
  });

  testWidgets(
      'When complete pin code with UnkownError'
      ' should return Snackbar with unknown error ', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state)
        .thenReturn(const MFAAuthenticationState(
      email: '',
      mfaInfo: MFAInfo(),
      mfaStatus: MFAAuthenticationStatus.configured,
      status: NetworkStatus.idle,
    ));

    when(
      () => mfaAuthenticationCubit.login(
        validationCode: any(named: 'validationCode'),
        tenant: any(named: 'tenant'),
        temporaryToken: any(
          named: 'temporaryToken',
        ),
      ),
    ).thenAnswer(
      (_) async => false,
    );

    whenListen(
      mfaAuthenticationCubit,
      Stream<MFAAuthenticationState>.fromIterable([
        const MFAAuthenticationState(
          email: '',
          mfaInfo: MFAInfo(),
          mfaStatus: MFAAuthenticationStatus.configured,
          status: NetworkStatus.idle,
        ),
        const MFAAuthenticationState(
          email: '',
          mfaInfo: MFAInfo(),
          mfaStatus: MFAAuthenticationStatus.configured,
          status: NetworkStatus.idle,
          errorType: ErrorType.unknown,
        ),
      ]),
      initialState: const MFAAuthenticationState(
        email: '',
        mfaInfo: MFAInfo(),
        mfaStatus: MFAAuthenticationStatus.configured,
        status: NetworkStatus.idle,
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    final seniorPinCodeFields = find.byWidgetPredicate(
      (widget) =>
          widget is SeniorPinCodeFields &&
          widget.length == 6 &&
          widget.keyboardType == TextInputType.number,
    );

    await tester.enterText(
      seniorPinCodeFields,
      '123456',
    );
    await tester.pumpAndSettle();

    await expectLater(find.byType(SnackBar), findsOneWidget);
    await expectLater(
        find.text('A problem has occurred. Please try again.'), findsOneWidget);
  });

  testWidgets('Should test clipboard paste', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state)
        .thenReturn(const MFAAuthenticationState(
      email: '',
      mfaInfo: MFAInfo(),
      mfaStatus: MFAAuthenticationStatus.configured,
      status: NetworkStatus.idle,
    ));

    await tester.pumpWidget(makeTestableWidget());

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();

    final MockClipboard mockClipboard = MockClipboard();
    TestWidgetsFlutterBinding.ensureInitialized()
        .defaultBinaryMessenger
        .setMockMethodCallHandler(
            SystemChannels.platform, mockClipboard.handleMethodCall);

    mockClipboard.clipboardData = <String, dynamic>{
      'text': '123456',
    };

    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);

    expect(data, isNotNull);
    expect(data!.text, equals('123456'));

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    final dialogTextFinder =
        find.text('Would you like to paste the code 123456?');
    expect(dialogTextFinder, findsOneWidget);
  });
}
