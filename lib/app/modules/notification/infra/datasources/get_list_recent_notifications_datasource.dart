import '../../../../core/pagination/pagination_requirements.dart';
import '../models/notification_model.dart';

abstract class GetListRecentNotificationsDatasource {
  Future<List<NotificationModel>> call({
    required PaginationRequirements paginationRequirements,
  });
}
