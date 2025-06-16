import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/base_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/reset_password_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/widgets/reset_password_content.dart';

import '../../../mocks/reset_password_mock.dart';

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
          child: const ResetPasswordScreen(
            resetPasswordInfo: resetPasswordInfoMock,
            username: 'userName',
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unauthenticated());

    await tester.pumpWidget(makeTestableWidget());

    final seniorBackdropFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorBackdrop && widget.hideLeading == false);
    final blocProviderFinder = find.byType(BlocProvider<ResetPasswordCubit>);
    final contentFinder = find.byType(ResetPasswordContent);

    expect(seniorBackdropFinder, findsOneWidget);
    expect(blocProviderFinder, findsOneWidget);
    expect(contentFinder, findsOneWidget);
  });
}
