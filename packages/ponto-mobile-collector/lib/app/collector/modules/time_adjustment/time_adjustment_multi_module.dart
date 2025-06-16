import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/services/navigator/navigator_service.dart';
import '../../core/infra/utils/iutils.dart';
import '../clocking_event/domain/usecase/get_clock_time_usecase.dart';
import '../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import '../routes/time_adjustment_multi_routes.dart';
import 'presenter/bloc/filter_employee_select/filter_employee_select_bloc.dart';
import 'presenter/bloc/period/period_bloc.dart';
import 'presenter/bloc/tab_action/tab_action_bloc.dart';
import 'presenter/bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_bloc.dart';
import 'presenter/bloc/timer_adjustment/timer_adjustment_bloc.dart';
import 'presenter/screen/filter_employee_select_screen.dart';
import 'presenter/screen/time_adjustment_screen.dart';
import 'presenter/screen/time_adjustment_select_employee_screen.dart';
import 'time_adjustment_binds.dart';

class TimeAdjustmentMultiModule extends Module {
  @override
  List<Module> get imports => [
        TimeAdjustmentBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          TimeAdjustmentMultiRoutes.home,
          child: (context, args) => TimeAdjustmentScreen(
            Modular.get<TabActionBloc>(),
            Modular.get<NavigatorService>(),
            Modular.get<PeriodBloc>(),
            Modular.get<TimerAdjustmentBloc>(),
            Modular.get<IGetClockDateTimeUsecase>(),
            Modular.get<SynchronizeClockingEventBloc>(),
            Modular.get<IUtils>(),
            Modular.get<IShowBottomSheetUsecase>(),
            hideBackButton: false,
            showNotificationButton: false,
            routeArguments: args.data,
          ),
        ),
        ChildRoute(
          '/${TimeAdjustmentMultiRoutes.filterEmployee}',
          child: (context, args) => FilterEmployeeSelectScreen(
            filterEmployeeSelectBloc: Modular.get<FilterEmployeeSelectBloc>(),
            utils: Modular.get<IUtils>(),
            periodBloc: Modular.get<PeriodBloc>(),
            navigatorService: Modular.get<NavigatorService>(),
            routeArguments: args.data,
            timerAdjustmentBloc: Modular.get<TimerAdjustmentBloc>(),
          ),
        ),
        ChildRoute(
          '/${TimeAdjustmentMultiRoutes.selectEmployee}',
          child: (context, args) => TimeAdjustmentSelectEmployeeScreen(
            timeAdjustmentSelectEmployeeBloc:
                Modular.get<TimeAdjustmentSelectEmployeeBloc>(),
            timerAdjustmentBloc: Modular.get<TimerAdjustmentBloc>(),
            navigatorService: Modular.get<NavigatorService>(),
            routeArguments: args.data,
            utils: Modular.get<IUtils>(),
          ),
        ),
      ];
}
