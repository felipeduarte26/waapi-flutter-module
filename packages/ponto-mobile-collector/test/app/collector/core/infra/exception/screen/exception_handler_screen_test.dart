import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/exception/screen/exception_handler_screen.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';

import 'package:senior_design_system/senior_design_system.dart';

void main() {
  late Widget errorExceptionHandlerScreen;
  late Widget alertExceptionHandlerScreen;
/*
  "collectorErrorFallbackTitle": "Serviço não esta respondendo",
  "collectorErrorFallbackMessage": "Não foi possível estabelecer uma conexão com o serviço do ponto.",
  "collectorErrorFallbackTryAgainButtonLabel": "Tentar novamente",
  "collectorErrorFallbackBackToLoginButtonLabel": "Voltar para Login"
*/
  setUpAll(() {
    errorExceptionHandlerScreen = ExceptionHandlerScreen(
      feedbackType: ExceptionTypeEnum.error,
      title: 'Serviço não esta respondendo',
      subtitle:
          'Não foi possível estabelecer uma conexão com o serviço do ponto.',
      actionButtonLabel: 'Voltar para Login',
      retryButtonLabel: 'Tentar novamente',
      onAction: () {},
      onRetry: () {},
    );

    alertExceptionHandlerScreen = ExceptionHandlerScreen(
      feedbackType: ExceptionTypeEnum.alert,
      title: 'Serviço não esta respondendo',
      subtitle:
          'Não foi possível estabelecer uma conexão com o serviço do ponto.',
      actionButtonLabel: 'Voltar para Login',
      retryButtonLabel: 'Tentar novamente',
      onAction: () {},
      onRetry: () {},
    );
  });

  Widget getWidget(Widget exceptionHandlerScreen) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: const Locale('pt'),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: exceptionHandlerScreen,
          ),
        ),
      ),
    );
  }

  group('Exception Handler Screen', () {
    testWidgets(
        'should return an error screen if ExceptionTypeEnum is ExceptionTypeEnum.error',
        (tester) async {
      final widget = getWidget(errorExceptionHandlerScreen);

      await tester.pumpWidget(widget);

      final errorIconFinder = find.byIcon(FontAwesomeIcons.circleExclamation);
      final alertIconFinder = find.byIcon(FontAwesomeIcons.triangleExclamation);
      final successIconFinder = find.byIcon(FontAwesomeIcons.solidCircleCheck);
      final titleFinder = find.text('Serviço não esta respondendo');
      final subtitleFinder = find.text(
        'Não foi possível estabelecer uma conexão com o serviço do ponto.',
      );
      final buttonOnActionFinder =
          find.widgetWithText(SeniorButton, 'Tentar novamente');
      final buttonOnRetryFinder =
          find.widgetWithText(SeniorButton, 'Voltar para Login');

      expect(errorIconFinder, findsOneWidget);
      expect(alertIconFinder, findsNothing);
      expect(successIconFinder, findsNothing);
      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);
      expect(buttonOnActionFinder, findsOneWidget);
      expect(buttonOnRetryFinder, findsOneWidget);
    });
    testWidgets(
        'should return an alert screen if ExceptionTypeEnum is ExceptionTypeEnum.alert',
        (tester) async {
      final widget = getWidget(alertExceptionHandlerScreen);

      await tester.pumpWidget(widget);

      final errorIconFinder = find.byIcon(FontAwesomeIcons.circleExclamation);
      final alertIconFinder = find.byIcon(FontAwesomeIcons.triangleExclamation);
      final successIconFinder = find.byIcon(FontAwesomeIcons.solidCircleCheck);
      final titleFinder = find.text('Serviço não esta respondendo');
      final subtitleFinder = find.text(
        'Não foi possível estabelecer uma conexão com o serviço do ponto.',
      );
      final buttonOnActionFinder =
          find.widgetWithText(SeniorButton, 'Tentar novamente');
      final buttonOnRetryFinder =
          find.widgetWithText(SeniorButton, 'Voltar para Login');

      expect(errorIconFinder, findsNothing);
      expect(alertIconFinder, findsOneWidget);
      expect(successIconFinder, findsNothing);
      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);
      expect(buttonOnActionFinder, findsOneWidget);
      expect(buttonOnRetryFinder, findsOneWidget);
    });
  });
}
