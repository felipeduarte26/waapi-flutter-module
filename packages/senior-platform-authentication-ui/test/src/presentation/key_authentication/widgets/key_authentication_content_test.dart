import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/presentation/key_authentication/widgets/key_authentication_content.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockKeyAuthenticationCubit extends MockCubit<KeyAuthenticationState>
    implements KeyAuthenticationCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late KeyAuthenticationCubit keyAuthenticationCubit;

  Widget makeTestableWidget(String? initialDomain) {
    return SeniorDesignSystem(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authenticationBloc,
          ),
          BlocProvider<KeyAuthenticationCubit>(
            create: (BuildContext context) => keyAuthenticationCubit,
          ),
        ],
        child: BaseAuthenticationScreen(
          child: SeniorBackdrop(
            hideLeading: true,
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.solidCircleQuestion),
                onPressed: () {},
              )
            ],
            title: Builder(
                builder: (context) => Text(context.l10n.loginWithKeyTitle)),
            body: KeyAuthenticationContent(
              initialDomain: initialDomain,
            ),
          ),
        ),
      ),
    );
  }

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    keyAuthenticationCubit = MockKeyAuthenticationCubit();
  });
  group('KeyAuthenticationContent', () {
    testWidgets('should show snackbar with domainNotFound error message test',
        (tester) async {
      whenListen(
        keyAuthenticationCubit,
        Stream<KeyAuthenticationState>.fromIterable([
          KeyAuthenticationState.initial().copyWith(
              status: NetworkStatus.idle, errorType: ErrorType.domainNotFound),
        ]),
        initialState: KeyAuthenticationState.initial(),
      );

      await tester.pumpWidget(makeTestableWidget(null));
      await tester.pump();
      expect(find.text('Domain not found'), findsOneWidget);
      await tester.tap(find.text('OK'));
    });

    testWidgets('should show snackbar with unauthorized error message test',
        (tester) async {
      whenListen(
        keyAuthenticationCubit,
        Stream<KeyAuthenticationState>.fromIterable([
          KeyAuthenticationState.initial().copyWith(
              status: NetworkStatus.idle, errorType: ErrorType.unauthorized),
        ]),
        initialState: KeyAuthenticationState.initial(),
      );

      await tester.pumpWidget(makeTestableWidget(null));
      await tester.pump();
      expect(find.text('Incorrect key or secret. Please try again'),
          findsOneWidget);
      await tester.tap(find.text('OK'));
    });

    testWidgets('should show snackbar with unknown error message test',
        (tester) async {
      whenListen(
        keyAuthenticationCubit,
        Stream<KeyAuthenticationState>.fromIterable([
          KeyAuthenticationState.initial().copyWith(
              status: NetworkStatus.idle, errorType: ErrorType.unknown),
        ]),
        initialState: KeyAuthenticationState.initial(),
      );

      await tester.pumpWidget(makeTestableWidget(null));
      await tester.pump();
      expect(find.text('A problem has occurred. Please try again.'),
          findsOneWidget);
      await tester.tap(find.text('OK'));
    });

    testWidgets('should call login test', (tester) async {
      whenListen(
        keyAuthenticationCubit,
        Stream<KeyAuthenticationState>.fromIterable([
          KeyAuthenticationState.initial().copyWith(
              status: NetworkStatus.idle,
              errorType: ErrorType.unknown,
              domainOK: true,
              accessKeyOK: true,
              secretOK: true),
        ]),
        initialState: KeyAuthenticationState.initial(),
      );

      await tester.pumpWidget(makeTestableWidget(null));
      await tester.pump();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      verify(
        () => keyAuthenticationCubit.login(),
      ).called(1);
    });
  });
}
