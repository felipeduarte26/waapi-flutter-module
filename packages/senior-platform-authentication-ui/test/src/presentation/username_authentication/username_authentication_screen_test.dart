import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../mocks/encryption_key_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late AuthenticationBloc authenticationBloc;

  setUp(() {
    SeniorAuthentication.initialize(
      encryptionKey: encryptionKeyMock,
    );
    authenticationBloc = MockAuthenticationBloc();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
        child: const UserNameAuthenticationScreen(),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    await tester.pumpWidget(makeTestableWidget());

    final userNameScreenSubtitleFinder = find.text('Log in');
    final seniorBackdropFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorBackdrop &&
        widget.hideLeading == true &&
        widget.actions != null);
    final blocProviderFinder =
        find.byType(BlocProvider<UserNameAuthenticationCubit>);
    final contentFinder = find.byType(UserNameAuthenticationContent);

    expect(userNameScreenSubtitleFinder, findsOneWidget);
    expect(seniorBackdropFinder, findsOneWidget);
    expect(blocProviderFinder, findsOneWidget);
    expect(contentFinder, findsOneWidget);
  });
}
