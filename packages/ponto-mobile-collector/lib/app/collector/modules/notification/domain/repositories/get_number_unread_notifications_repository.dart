import '../types/notification_domain_types.dart';

abstract class GetNumberUnreadNotificationsRepository {
  GetNumberUnreadNotificationsCallback call({
    required String employeeId,
  });
}
