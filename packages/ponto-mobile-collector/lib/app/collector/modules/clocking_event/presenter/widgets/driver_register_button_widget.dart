import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../routes/collector_routes.dart';
import '../bloc/clocking_event/clocking_event_bloc.dart';
import '../bloc/clocking_event/clocking_event_event.dart';

class DriverRegisterButtonWidget extends StatelessWidget {
  final NavigatorService navigatorService;
  final ClockingEventBloc clockingEventBloc;

  const DriverRegisterButtonWidget({
    required this.navigatorService,
    required this.clockingEventBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SeniorButton.primary(
      fullWidth: true,
      busyMessage: CollectorLocalizations.of(context).driversJourney,
      icon: FontAwesomeIcons.truck,
      label: CollectorLocalizations.of(context).driversJourney,
      onPressed: () async {
        await navigatorService.pushNamed(
          route: '/${PontoMobileCollectorRoutes.driversJourney}',
        );
        clockingEventBloc.add(LoadClockingEventEvent());
      },
    );
  }
}
