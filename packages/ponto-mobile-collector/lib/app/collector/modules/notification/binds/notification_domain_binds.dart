import 'package:flutter_modular/flutter_modular.dart';

import '../../clocking_event/domain/usecase/get_employee_usecase.dart';
import '../domain/usecases/confirm_read_push_message_usecase.dart';
import '../domain/usecases/get_list_recent_notifications_usecase.dart';
import '../domain/usecases/get_number_unread_notifications_usecase.dart';

class NotificationDomainBinds {
  static List<Bind<Object>> binds = [
    // UseCases
    Bind.lazySingleton<GetListRecentNotificationsUseCase>(
      (i) {
        return GetListRecentNotificationsUseCaseImpl(
          pushNotificationsRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNumberUnreadNotificationsUsecase>(
      (i) {
        GetEmployeeUsecase? getEmployeeUsecase;
        try {
          getEmployeeUsecase = i.get<GetEmployeeUsecase>();
        } catch (e) {
          getEmployeeUsecase = null;
        }
        return GetNumberUnreadNotificationsUsecaseImpl(
          getNumberUnreadNotificationsRepository: i.get(),
          getEmployeeUsecase: getEmployeeUsecase,
        );
      },
      export: true,
    ),

    Bind.lazySingleton<ConfirmReadPushMessageUseCase>(
      (i) {
        return ConfirmReadPushMessageUseCaseImpl(
          confirmReadPushMessageRepository: i.get(),
        );
      },
      export: true,
    ),
  ];
}
