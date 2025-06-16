import '../repositories/get_number_unread_notifications_repository.dart';
import '../types/notification_domain_types.dart';

abstract class GetNumberUnreadNotificationsUsecase {
  GetNumberUnreadNotificationsCallback call();
}

class GetNumberUnreadNotificationsUsecaseImpl implements GetNumberUnreadNotificationsUsecase {
  final GetNumberUnreadNotificationsRepository _getNumberUnreadNotificationsRepository;

  const GetNumberUnreadNotificationsUsecaseImpl({
    required GetNumberUnreadNotificationsRepository getNumberUnreadNotificationsRepository,
  }) : _getNumberUnreadNotificationsRepository = getNumberUnreadNotificationsRepository;

  @override
  GetNumberUnreadNotificationsCallback call() {
    return _getNumberUnreadNotificationsRepository.call();
  }
}
