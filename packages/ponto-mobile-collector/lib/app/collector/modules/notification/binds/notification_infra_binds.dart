import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/confirm_read_push_message_repository.dart';
import '../domain/repositories/get_number_unread_notifications_repository.dart';
import '../domain/repositories/push_notifications_repository.dart';
import '../infra/repositories/confirm_read_push_message_repository_impl.dart';
import '../infra/repositories/get_number_unread_notifications_repository_impl.dart';
import '../infra/repositories/push_notifications_repository_impl.dart';

class NotificationInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.lazySingleton<PushNotificationsRepository>(
      (i) {
        return PushNotificationsRepositoryImpl(
          getPushNotificationsDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNumberUnreadNotificationsRepository>(
      (i) {
        return GetNumberUnreadNotificationsRepositoryImpl(
          getNumberUnreadNotificationsDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<ConfirmReadPushMessageRepository>(
      (i) {
        return ConfirmReadPushMessageRepositoryImpl(
          confirmReadPushMessageDataSource: i.get(),
        );
      },
      export: true,
    ),

  ];
}
