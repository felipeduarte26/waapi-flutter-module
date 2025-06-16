import '../types/notification_domain_types.dart';

abstract class PushNotificationsRepository {
  GetListRecentNotificationsCallback call({
    required String employeeId,
  });
}
