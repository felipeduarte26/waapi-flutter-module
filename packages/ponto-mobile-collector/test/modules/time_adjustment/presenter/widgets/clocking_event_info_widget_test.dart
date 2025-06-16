import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

void main() {
  Widget getWidget(String locale) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: SeniorDesignSystem(
          theme: SENIOR_LIGHT_THEME,
          child: const ClockingEventInfoWidget(
            showManual: true,
            showMobile: true,
            showOdd: true,
            showPlatform: true,
            showRemoteness: true,
            showSynced: true,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'ClockingEventInfoWidget show widget test',
    (tester) async {
      Widget widget = getWidget(
        'pt',
      );

      await tester.pumpWidget(widget);

      final iconDesktopFinder1 = find.byIcon(FontAwesomeIcons.rotate);
      final iconDesktopFinder2 =
          find.byIcon(FontAwesomeIcons.mobileScreenButton);
      final iconDesktopFinder3 = find.byIcon(FontAwesomeIcons.desktop);
      final iconDesktopFinder4 = find.byIcon(FontAwesomeIcons.squarePen);
      final iconDesktopFinder5 =
          find.byIcon(FontAwesomeIcons.solidCalendarXmark);
      final iconDesktopFinder6 = find.byIcon(FontAwesomeIcons.userInjured);

      expect(iconDesktopFinder1, findsOneWidget);
      expect(iconDesktopFinder2, findsOneWidget);
      expect(iconDesktopFinder3, findsOneWidget);
      expect(iconDesktopFinder4, findsOneWidget);
      expect(iconDesktopFinder5, findsOneWidget);
      expect(iconDesktopFinder6, findsOneWidget);

      final titleFinder1 = find.text('Marcação não sincronizada');
      final titleFinder2 = find.text('Origem via celular');
      final titleFinder3 = find.text('Origem via plataforma');
      final titleFinder4 = find.text('Marcação manual');
      final titleFinder5 = find.text('Marcações ímpares');
      final titleFinder6 = find.text('Marcações com afastamento');

      expect(titleFinder1, findsOneWidget);
      expect(titleFinder2, findsOneWidget);
      expect(titleFinder3, findsOneWidget);
      expect(titleFinder4, findsOneWidget);
      expect(titleFinder5, findsOneWidget);
      expect(titleFinder6, findsOneWidget);

      final descriptionFinder1 = find.text(
        'São marcações que foram registradas e serão sincronizadas assim que houver conexão com a internet.',
      );
      final descriptionFinder2 = find.text(
        'São marcações que foram registradas via aplicativo tanto Ponto quanto Waapi.',
      );
      final descriptionFinder3 =
          find.text('São marcações que foram registradas via plataforma.');
      final descriptionFinder4 = find.text(
        'Marcações registradas manualmente pelo gestor ou colaborador através do app ou plataforma.',
      );
      final descriptionFinder5 =
          find.text('Significa que falta uma marcação para sua jornada ficar completa, porém ela pode ter sido realizada em outro registrador de ponto.');
      final descriptionFinder6 = find.text(
        'São marcações que possuem algum afastamento lançado na jornada.',
      );

      expect(descriptionFinder1, findsOneWidget);
      expect(descriptionFinder2, findsOneWidget);
      expect(descriptionFinder3, findsOneWidget);
      expect(descriptionFinder4, findsOneWidget);
      expect(descriptionFinder5, findsOneWidget);
      expect(descriptionFinder6, findsOneWidget);

      final buttonFinder = find.text('Entendi');
      expect(buttonFinder, findsOneWidget);
    },
  );
}
