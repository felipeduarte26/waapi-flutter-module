import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_face_registration_message_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockNavigatorService extends Mock implements NavigatorService {}

class MockShowFaceRegistrationMessageUsecase extends Mock
    implements ShowFaceRegistrationMessageUsecase {}

void main() {
  late FacialRegistrationMessageWidget facialRegistrationMessageWidget;
  late NavigatorService navigatorService;
  late ShowFaceRegistrationMessageUsecase showFaceRegistrationMessageUsecase;

  setUp(() {
    navigatorService = MockNavigatorService();
    showFaceRegistrationMessageUsecase =
        MockShowFaceRegistrationMessageUsecase();

    when(
      () => navigatorService.popAndPushNamed(
        route:
            '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.registrationFull}',
      ),
    ).thenAnswer((_) async => true);

    when(() => navigatorService.pop()).thenReturn(null);

    when(
      () => showFaceRegistrationMessageUsecase.call(any()),
    ).thenAnswer((_) async => true);
  });

  Widget getWidget() {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: const Locale('pt'),
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return FilledButton(
                  child: const Text('show'),
                  onPressed: () {
                    facialRegistrationMessageWidget =
                        FacialRegistrationMessageWidget(
                      context: context,
                      navigatorService: navigatorService,
                      showFaceRegistrationMessageUsecase:
                          showFaceRegistrationMessageUsecase,
                    );

                    facialRegistrationMessageWidget.show();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  group('FacialRegistrationMessageWidget', () {
    testWidgets('show message and confirm face register test', (tester) async {
      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('show');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      expect(
        find.text('Realizar o cadastro de reconhecimento facial?'),
        findsOneWidget,
      );

      expect(
        find.text(
          'Você ainda não cadastrou seu rosto para registro do ponto com reconhecimento facial. Cadastre agora e garanta mais segurança e agilidade dos seus dados.',
        ),
        findsOneWidget,
      );

      expect(
        find.text('Cadastrar agora'),
        findsOneWidget,
      );

      expect(
        find.text('Fechar'),
        findsOneWidget,
      );

      await tester.tap(find.text('Cadastrar agora'));

      verify(
        () => navigatorService.popAndPushNamed(
          route:
              '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.registrationFull}',
        ),
      );

      verify(
        () => showFaceRegistrationMessageUsecase.call(any()),
      );
    });

    testWidgets('show message and cancel face register test', (tester) async {
      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('show');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Fechar'));
      verify(() => navigatorService.pop());
      verify(
        () => showFaceRegistrationMessageUsecase.call(any()),
      );
    });

    testWidgets('do not display message test', (tester) async {
      when(
        () => showFaceRegistrationMessageUsecase.call(any()),
      ).thenAnswer((_) async => false);

      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('show');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      verify(
        () => showFaceRegistrationMessageUsecase.call(any()),
      );
    });
  });
}
