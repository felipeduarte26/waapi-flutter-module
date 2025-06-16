import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/cubit/password_recovery_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_recaptcha.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/recaptcha_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../mocks/change_password_settings_mock.dart';
import '../../../../mocks/webview/webview_platform_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockPasswordRecoveryCubit extends MockCubit<PasswordRecoveryState>
    implements PasswordRecoveryCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late PasswordRecoveryCubit passwordRecoveryCubit;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    passwordRecoveryCubit = MockPasswordRecoveryCubit();
    WebViewPlatform.instance = WebViewPlatformMock();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) => authenticationBloc,
            ),
            BlocProvider<PasswordRecoveryCubit>(
              create: (BuildContext context) => passwordRecoveryCubit,
            ),
          ],
          child: const PasswordRecoveryRecaptcha(
            changePasswordSettings: changePasswordSettingsMock,
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state)
        .thenReturn(PasswordRecoveryState.initial().copyWith(
      passwordRecoveryStatus: PasswordRecoveryStatus.recaptcha,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final passwordRecoveryRecaptchaFinder =
        find.byType(PasswordRecoveryRecaptcha);
    final blocBuilderFinder =
        find.byType(BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>);
    final recoveryPasswordRecaptchaTitleFinder =
        find.text('Please fill in the recaptcha to proceed');
    final recaptchaWebviewFinder = find.byType(RecaptchaWebView);

    expect(passwordRecoveryRecaptchaFinder, findsOneWidget);
    expect(blocBuilderFinder, findsOneWidget);
    expect(recoveryPasswordRecaptchaTitleFinder, findsOneWidget);
    expect(recaptchaWebviewFinder, findsNothing);
  });
}
