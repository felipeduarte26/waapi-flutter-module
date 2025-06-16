import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_list_recent_notifications_repository.dart';
import '../types/notification_domain_types.dart';

abstract class GetListRecentNotificationsUseCase {
  GetListRecentNotificationsCallback call({
    required PaginationRequirements paginationRequirements,
  });
}

class GetListRecentNotificationsUseCaseImpl implements GetListRecentNotificationsUseCase {
  final GetListRecentNotificationsRepository _getListRecentNotificationsRepository;

  const GetListRecentNotificationsUseCaseImpl({
    required GetListRecentNotificationsRepository getListRecentNotificationsRepository,
  }) : _getListRecentNotificationsRepository = getListRecentNotificationsRepository;

  @override
  GetListRecentNotificationsCallback call({
    required PaginationRequirements paginationRequirements,
  }) {
    return _getListRecentNotificationsRepository.call(
      paginationRequirements: paginationRequirements,
    );
  }
}
