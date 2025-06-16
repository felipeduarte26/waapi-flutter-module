import '../input_models/mark_notification_as_read_input_model.dart';
import '../types/notification_domain_types.dart';

abstract class MarkNotificationAsReadRepository {
  MarkNotificationAsReadCallback call({
    required MarkNotificationAsReadInputModel markNotificationAsReadInputModel,
  });
}
