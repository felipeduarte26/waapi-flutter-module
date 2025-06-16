import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/widgets/reset_password_content.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/widgets/reset_password_error.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/widgets/reset_password_loading.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/widgets/reset_password_view.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockResetPasswordCubit extends MockCubit<ResetPasswordState>
    implements ResetPasswordCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late ResetPasswordCubit resetPasswordCubit;
  const tUsername = 'username';
  const tTemporaryToken = 'temporaryToken';
  final tPasswordPolicySettings = PasswordPolicySettings(
    minimumPasswordLength: 6,
    maximumPasswordLength: 30,
    requireNumbers: true,
    requireLowercase: true,
    requireUppercase: true,
    requireSpecialCharacters: true,
  );

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    resetPasswordCubit = MockResetPasswordCubit();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authenticationBloc,
          ),
          BlocProvider<ResetPasswordCubit>(
            create: (BuildContext context) => resetPasswordCubit,
          ),
        ],
        child: BaseAuthenticationScreen(
          child: SeniorBackdrop(
            title: Builder(
                builder: (context) =>
                    Text(context.l10n.resetPasswordScreenTitle)),
            body: const ResetPasswordContent(),
          ),
        ),
      ),
    );
  }

  testWidgets(
      'should render correctly when state.status is ResetPasswordState is initialized correctly',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => resetPasswordCubit.state)
        .thenReturn(ResetPasswordState.initial().copyWith(
      username: tUsername,
      temporaryToken: tTemporaryToken,
      passwordPolicySettings: tPasswordPolicySettings,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder =
        find.byType(BlocBuilder<ResetPasswordCubit, ResetPasswordState>);
    final resetPasswordViewFinder = find.byType(ResetPasswordView);

    expect(blocBuilderFinder, findsOneWidget);
    expect(resetPasswordViewFinder, findsOneWidget);
  });

  testWidgets(
      'should render correctly when state.status is ResetPasswordState is initializing',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => resetPasswordCubit.state)
        .thenReturn(ResetPasswordState.initial().copyWith(
      networkStatus: NetworkStatus.loading,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder =
        find.byType(BlocBuilder<ResetPasswordCubit, ResetPasswordState>);
    final resetPasswordLoadingFinder = find.byType(ResetPasswordLoading);

    expect(blocBuilderFinder, findsOneWidget);
    expect(resetPasswordLoadingFinder, findsOneWidget);
  });

  testWidgets(
      'should render correctly when state.status is ResetPasswordState is initialized with errors',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => resetPasswordCubit.state)
        .thenReturn(ResetPasswordState.initial().copyWith(
      errorType: ErrorType.unknown,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder =
        find.byType(BlocBuilder<ResetPasswordCubit, ResetPasswordState>);
    final resetPasswordErrorFinder = find.byType(ResetPasswordError);

    expect(blocBuilderFinder, findsOneWidget);
    expect(resetPasswordErrorFinder, findsOneWidget);
  });
}
