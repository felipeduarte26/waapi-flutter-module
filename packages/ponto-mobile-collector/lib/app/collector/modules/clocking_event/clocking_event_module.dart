import 'package:flutter_modular/flutter_modular.dart';

import '../../../../ponto_mobile_collector.dart';
import '../../core/domain/services/navigator/navigator_service.dart';
import 'domain/usecase/show_face_registration_message_usecase.dart';
import 'presenter/screen/clocking_event_screen.dart';

class ClockingEventModule extends Module {
  @override
  List<Module> get imports => [
        ClockingEventBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          ClockingEventRoutes.home,
          child: (context, args) => ClockingEventScreen(
            timerBloc: Modular.get(),
            clockingEventBloc: Modular.get(),
            menuActionCubit: Modular.get(),
            clockingEventWidget: ClockingEventWidget(
              clockingEventBloc: Modular.get(),
              clockingEventUtil: Modular.get(),
              workIndicatorCubit: Modular.get(),
              registerClockingEventBloc: Modular.get(),
              showBottomSheetUsecase: Modular.get(),
              timerBloc: Modular.get(),
              navigatorService: Modular.get<NavigatorService>(),
              facialRegistrationMessageWidget: FacialRegistrationMessageWidget(
                context: context,
                navigatorService: Modular.get(),
                showFaceRegistrationMessageUsecase: Modular.get<ShowFaceRegistrationMessageUsecase>(),
              ),
              confirmationSnackbarWidget: ConfirmationSnackbarWidget(
                utils: Modular.get(),
                getReceiptUsecase: Modular.get(),
                context: context,
                showBottomSheetUsecase: Modular.get(),
              ),
              platformService: Modular.get<IPlatformService>(),
              getLifecycleStreamUsecase: Modular.get(),
            ),
            navigatorService: Modular.get(),
            hideBackButton: true,
            showNotificationButton:
                CollectorModuleService.isShowNotificationButton,
            counterNotificationsBloc: Modular.get(),
          ),
        ),
      ];
}
