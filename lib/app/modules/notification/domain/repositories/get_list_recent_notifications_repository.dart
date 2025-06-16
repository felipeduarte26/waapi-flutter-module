import '../../../../core/pagination/pagination_requirements.dart';
import '../types/notification_domain_types.dart';

abstract class GetListRecentNotificationsRepository {
  GetListRecentNotificationsCallback call({
    required PaginationRequirements paginationRequirements,
  });
}
