import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/app/collector/modules/hours/presenter/cubit/hours_tab_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

void main() {
  String configurationScreen = 'configurationScreen';
  late HoursTabCubit hoursTabCubit;

  setUp(() {
    hoursTabCubit = HoursTabCubit();
  });

  Widget getWidget(String locale) {
    return MaterialApp(
      routes: {
        '/${PontoMobileCollectorRoutes.configurationHome}': (context) =>
            Text(configurationScreen),
      },
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: HoursScreen(
              hoursTabCubit: hoursTabCubit,
            ),
          ),
        ),
      ),
    );
  }

  group('HoursScreen', () {
    testWidgets(
      'Call Notification screen test',
      (tester) async {
        Widget widget = getWidget('en');
        await tester.pumpWidget(widget);

        Finder eventFinder = find.byIcon(FontAwesomeIcons.solidBell);
        expect(eventFinder, findsOneWidget);

        await tester.tap(eventFinder);
        await tester.pumpAndSettle();
      },
    );

    testWidgets('Call configuration screen test', (tester) async {
      Widget widget = getWidget('en');
      await tester.pumpWidget(widget);

      Finder configurationFinder = find.byIcon(FontAwesomeIcons.gear);
      expect(configurationFinder, findsOneWidget);

      await tester.tap(configurationFinder);
      await tester.pumpAndSettle();

      Finder configurationRouterFinder = find.text(configurationScreen);
      expect(configurationRouterFinder, findsOneWidget);
    });

    testWidgets('show ConfigurationScreen English', (tester) async {
      Widget widget = getWidget('pt');
      await tester.pumpWidget(widget);

      Finder tab1Finder = find.text('Jornada do dia');
      expect(tab1Finder, findsOneWidget);

      Finder tab2Finder = find.text('Saldo');
      expect(tab2Finder, findsOneWidget);
      
      Finder tab3Finder = find.text('Espelho');
      expect(tab3Finder, findsOneWidget);

      await tester.tap(tab2Finder);
      await tester.pumpAndSettle();
    });
  });
}
