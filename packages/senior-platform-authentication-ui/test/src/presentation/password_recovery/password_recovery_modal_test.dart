import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/cubit/password_recovery_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/password_recovery_modal.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_content.dart';

import '../../../mocks/change_password_settings_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late AuthenticationBloc authenticationBloc;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
          child: const PasswordRecoveryModal(
            changePasswordSettings: changePasswordSettingsMock,
            username: 'userName',
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    await tester.pumpWidget(makeTestableWidget());

    final blocProviderFinder = find.byType(BlocProvider<PasswordRecoveryCubit>);
    final contentFinder = find.byType(PasswordRecoveryContent);

    expect(blocProviderFinder, findsOneWidget);
    expect(contentFinder, findsOneWidget);
  });
}
