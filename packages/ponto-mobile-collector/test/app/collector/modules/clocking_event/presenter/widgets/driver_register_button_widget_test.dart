import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/clocking_event/clocking_event_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/widgets/driver_register_button_widget.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations_pt.dart';
import 'package:senior_design_system/components/senior_design_system/senior_design_system_widget.dart';
import 'package:senior_design_system/theme/themes/light_theme.dart';

class MockNavigatorService extends Mock implements NavigatorService {}

class MockClockingEventBloc extends Mock implements ClockingEventBloc {}

void main() {
  late NavigatorService navigatorService;
  late ClockingEventBloc clockingEventBloc;

  setUp(() {
    navigatorService = MockNavigatorService();
    clockingEventBloc = MockClockingEventBloc();

    when(
      () => navigatorService.pushNamed(
        route: '/${PontoMobileCollectorRoutes.driversJourney}',
      ),
    ).thenAnswer((_) async => null);
  });

  Widget getWidget(String locale) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: Scaffold(
            body: DriverRegisterButtonWidget(
              navigatorService: navigatorService,
              clockingEventBloc: clockingEventBloc,
            ),
          ),
        ),
      ),
    );
  }

  group('DriverRegisterButtonWidget', () {
    testWidgets('press button and navigate to driver screen test',
        (tester) async {
      await tester.pumpWidget(getWidget('pt'));

      expect(find.byIcon(FontAwesomeIcons.truck), findsOneWidget);
      expect(
        find.text(CollectorLocalizationsPt().driversJourney),
        findsOneWidget,
      );

      await tester.tap(find.byIcon(FontAwesomeIcons.truck));

      when(
        () => navigatorService.pushNamed(
          route: '/${PontoMobileCollectorRoutes.driversJourney}',
        ),
      );
    });
  });
}
