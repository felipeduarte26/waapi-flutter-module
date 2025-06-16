import '../repositories/clear_all_user_notifications_repository.dart';
import '../types/notification_domain_types.dart';

abstract class ClearAllUserNotificationsUsecase {
  ClearAllUserNotificationsCallback call();
}

class ClearAllUserNotificationsUsecaseImpl implements ClearAllUserNotificationsUsecase {
  final ClearAllUserNotificationsRepository _clearAllUserNotificationsRepository;

  const ClearAllUserNotificationsUsecaseImpl({
    required ClearAllUserNotificationsRepository clearAllUserNotificationsRepository,
  }) : _clearAllUserNotificationsRepository = clearAllUserNotificationsRepository;

  @override
  ClearAllUserNotificationsCallback call() {
    return _clearAllUserNotificationsRepository.call();
  }
}
