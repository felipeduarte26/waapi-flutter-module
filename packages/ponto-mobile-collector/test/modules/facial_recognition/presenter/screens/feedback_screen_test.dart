import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/feedback_screen.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';

import 'package:senior_design_system/senior_design_system.dart';

class MockNavigatorService extends Mock implements NavigatorService {}

void main() {
  late Widget errorFeedbackScreen;
  late Widget alertFeedbackScreen;
  late Widget successFeedbackScreen;
  late NavigatorService navigatorService;

  setUpAll(() {
    navigatorService = MockNavigatorService();

    errorFeedbackScreen = FeedbackScreen(
      navigatorService: navigatorService,
      feedbackType: FeedbackTypeEnum.error,
      title: 'Encontramos um problema!',
      subtitle: 'Não foi possível analisar a foto, tente submeta-la novamente',
      button: SeniorButton(
        label: 'Tentar novamente',
        onPressed: () {},
      ),
    );

    alertFeedbackScreen = FeedbackScreen(
      navigatorService: navigatorService,
      feedbackType: FeedbackTypeEnum.alert,
      title: 'Encontramos um problema!',
      subtitle: 'Não identificamos um rosto na imagem.',
      button: SeniorButton(
        label: 'Tentar novamente',
        onPressed: () {},
      ),
    );

    successFeedbackScreen = FeedbackScreen(
      navigatorService: navigatorService,
      feedbackType: FeedbackTypeEnum.success,
      title: 'Cadastro realizado com sucesso!',
      subtitle:
          'Agora o registro por reconhecimento facial está disponível para o você.',
      button: SeniorButton(
        label: 'Voltar ao início',
        onPressed: () {},
      ),
    );
  });

  Widget getWidget(Widget feedbackScreen) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: const Locale('pt'),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: feedbackScreen,
          ),
        ),
      ),
    );
  }

  group('Feedback Screen', () {
    testWidgets(
        'should return an error screen if FeedbackTypeEnum is FeedbackTypeEnum.error',
        (tester) async {
      final widget = getWidget(errorFeedbackScreen);

      await tester.pumpWidget(widget);

      final errorIconFinder = find.byIcon(FontAwesomeIcons.circleExclamation);
      final alertIconFinder = find.byIcon(FontAwesomeIcons.triangleExclamation);
      final successIconFinder = find.byIcon(FontAwesomeIcons.solidCircleCheck);
      final titleFinder = find.text('Encontramos um problema!');
      final subtitleFinder = find
          .text('Não foi possível analisar a foto, tente submeta-la novamente');
      final buttonFinder =
          find.widgetWithText(SeniorButton, 'Tentar novamente');

      expect(errorIconFinder, findsOneWidget);
      expect(alertIconFinder, findsNothing);
      expect(successIconFinder, findsNothing);
      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets(
        'should return an alert screen if FeedbackTypeEnum is FeedbackTypeEnum.alert',
        (tester) async {
      final widget = getWidget(alertFeedbackScreen);

      await tester.pumpWidget(widget);

      final errorIconFinder = find.byIcon(FontAwesomeIcons.circleExclamation);
      final alertIconFinder = find.byIcon(FontAwesomeIcons.triangleExclamation);
      final successIconFinder = find.byIcon(FontAwesomeIcons.solidCircleCheck);
      final titleFinder = find.text('Encontramos um problema!');
      final subtitleFinder = find.text('Não identificamos um rosto na imagem.');
      final buttonFinder =
          find.widgetWithText(SeniorButton, 'Tentar novamente');

      expect(errorIconFinder, findsNothing);
      expect(alertIconFinder, findsOneWidget);
      expect(successIconFinder, findsNothing);
      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets(
        'should return an success screen if FeedbackTypeEnum is FeedbackTypeEnum.success',
        (tester) async {
      final widget = getWidget(successFeedbackScreen);

      await tester.pumpWidget(widget);

      final errorIconFinder = find.byIcon(FontAwesomeIcons.circleExclamation);
      final alertIconFinder = find.byIcon(FontAwesomeIcons.triangleExclamation);
      final successIconFinder = find.byIcon(FontAwesomeIcons.solidCircleCheck);
      final titleFinder = find.text('Cadastro realizado com sucesso!');
      final subtitleFinder = find.text(
        'Agora o registro por reconhecimento facial está disponível para o você.',
      );
      final buttonFinder =
          find.widgetWithText(SeniorButton, 'Voltar ao início');

      expect(errorIconFinder, findsNothing);
      expect(alertIconFinder, findsNothing);
      expect(successIconFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('close screen on onPressedCloseCalled passed test',
        (tester) async {
      bool onPressedCloseCalled = false;
      FeedbackScreen myScreen = FeedbackScreen(
        navigatorService: navigatorService,
        feedbackType: FeedbackTypeEnum.success,
        title: 'title',
        subtitle: 'subtitle',
        button: SeniorButton(
          label: 'label',
          onPressed: () {},
        ),
        onPressedClose: () {
          onPressedCloseCalled = true;
        },
      );

      final widget = getWidget(myScreen);
      await tester.pumpWidget(widget);

      final closeIconFinder = find.byIcon(FontAwesomeIcons.xmark);
      expect(closeIconFinder, findsOneWidget);
      await tester.tap(closeIconFinder);
      await tester.pumpAndSettle();
      expect(onPressedCloseCalled, true);
    });

    testWidgets('close screen on onPressedCloseCalled not passed test',
        (tester) async {
      when(() => navigatorService.pop()).thenReturn(() {});
      FeedbackScreen myScreen = FeedbackScreen(
        navigatorService: navigatorService,
        feedbackType: FeedbackTypeEnum.success,
        title: 'title',
        subtitle: 'subtitle',
        button: SeniorButton(
          label: 'label',
          onPressed: () {},
        ),
      );

      final widget = getWidget(myScreen);
      await tester.pumpWidget(widget);

      final closeIconFinder = find.byIcon(FontAwesomeIcons.xmark);
      expect(closeIconFinder, findsOneWidget);
      await tester.tap(closeIconFinder);
      await tester.pumpAndSettle();
      verify(() => navigatorService.pop());
    });
  });
}
