import 'package:flutter_modular/flutter_modular.dart';

import '../../clocking_event/domain/usecase/get_employee_usecase.dart';
import '../presenter/blocs/confirm_read_push_message/confirm_read_push_message_bloc.dart';
import '../presenter/blocs/counter_notifications_bloc/counter_notifications_bloc.dart';
import '../presenter/blocs/list_notifications_bloc/list_notifications_bloc.dart';
import '../presenter/screens/list_notifications/bloc/list_notifications_screen_bloc.dart';

class NotificationPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.lazySingleton(
      (i) {
        GetEmployeeUsecase? getEmployeeUsecase;
        try {
          getEmployeeUsecase = i.get<GetEmployeeUsecase>();
        } catch (e) {
          getEmployeeUsecase = null;
        }
        return ListNotificationsBloc(
          getListRecentNotificationsUseCase: i.get(),
          hasConnectivityUsecase: i.get(),
          getEmployeeUsecase: getEmployeeUsecase,
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return CounterNotificationsBloc(
          getNumberUnreadNotificationsUsecase: i.get(),
          hasConnectivityUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return ConfirmReadPushMessageBloc(
          confirmReadPushMessageUseCase: i.get(),
          counterNotificationsBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return ListNotificationsScreenBloc(
          listNotificationsBloc: i.get(),
          confirmReadPushMessageBloc: i.get(),
          sessionService: i.get(),
        );
      },
      export: true,
    ),
  ];
}
