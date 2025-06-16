import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/key_authentication/widgets/key_authentication_content.dart';

import '../../../mocks/encryption_key_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockKeyAuthenticationCubit extends MockCubit<KeyAuthenticationState>
    implements KeyAuthenticationCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late KeyAuthenticationCubit keyAuthenticationCubit;

  setUp(() {
    SeniorAuthentication.initialize(encryptionKey: encryptionKeyMock);
    authenticationBloc = MockAuthenticationBloc();
    keyAuthenticationCubit = MockKeyAuthenticationCubit();
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: SeniorDesignSystem(
        child: BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
          child: const KeyAuthenticationScreen(),
        ),
      ),
    );
  }

  group('KeyAuthenticationScreen', () {
    testWidgets('should render correctly', (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      when(() => keyAuthenticationCubit.onDomainChanged(any()))
          .thenReturn(null);

      when(() => keyAuthenticationCubit.getTenantLoginSettings())
          .thenAnswer((_) async => null);

      await tester.pumpWidget(makeTestableWidget());

      final seniorBackdropFinder = find.byWidgetPredicate((widget) =>
          widget is SeniorBackdrop &&
          widget.hideLeading == false &&
          widget.actions != null);

      expect(seniorBackdropFinder, findsOneWidget);
      expect(find.text('Key configuration'), findsOneWidget);
      expect(find.byType(BlocProvider<KeyAuthenticationCubit>), findsOneWidget);
      expect(seniorBackdropFinder, findsOneWidget);
      expect(find.byType(KeyAuthenticationContent), findsOneWidget);
    });
  });
}
