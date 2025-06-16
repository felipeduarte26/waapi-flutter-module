import 'package:flutter_modular/flutter_modular.dart';

import '../../../../ponto_mobile_collector.dart';
import '../../core/infra/services/navigator/navigator_service_impl.dart';
import '../../core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import '../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../clocking_event/domain/usecase/show_face_registration_message_usecase.dart';

class DriversJourneyModule extends Module {
  @override
  List<Module> get imports => [
        DriversJourneyBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          DriversJourneyRoutes.home,
          child: (context, args) => DriversJourneyScreen(
            registerClockingEventBloc: Modular.get<RegisterClockingEventBloc>(),
            timerBloc: Modular.get<TimerBloc>(),
            workIndicatorCubit: Modular.get<WorkIndicatorCubit>(),
            driversJourneyBloc: Modular.get<DriversJourneyBloc>(),
            showBottomSheetUsecase: Modular.get<IShowBottomSheetUsecase>(),
            utils: Modular.get<IUtils>(),
            navigatorService: Modular.get<NavigatorServiceImpl>(),
            clockingEventBloc: Modular.get<ClockingEventBloc>(),
            facialRegistrationMessageWidget: FacialRegistrationMessageWidget(
              context: context,
              navigatorService: Modular.get(),
              showFaceRegistrationMessageUsecase:
                  Modular.get<ShowFaceRegistrationMessageUsecase>(),
            ),
            confirmationSnackbarWidget: ConfirmationSnackbarWidget(
              utils: Modular.get(),
              getReceiptUsecase: Modular.get(),
              context: context,
              showBottomSheetUsecase: Modular.get(),
            ),
          ),
        ),
      ];
}
