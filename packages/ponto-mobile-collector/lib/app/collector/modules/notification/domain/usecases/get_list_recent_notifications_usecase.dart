import '../repositories/push_notifications_repository.dart';
import '../types/notification_domain_types.dart';

abstract class GetListRecentNotificationsUseCase {
  GetListRecentNotificationsCallback call({
    required String employeeId,
  });
}

class GetListRecentNotificationsUseCaseImpl
    implements GetListRecentNotificationsUseCase {
  final PushNotificationsRepository _pushNotificationsRepository;

  const GetListRecentNotificationsUseCaseImpl({
    required PushNotificationsRepository pushNotificationsRepository,
  }) : _pushNotificationsRepository = pushNotificationsRepository;

  @override
  GetListRecentNotificationsCallback call({
    required String employeeId,
  }) async {
    return _pushNotificationsRepository.call(
      employeeId: employeeId,
    );
  }
}
