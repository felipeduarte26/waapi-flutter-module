import '../../domain/input_models/mark_notification_as_read_input_model.dart';

abstract class MarkNotificationAsReadDatasource {
  Future<void> call({
    required MarkNotificationAsReadInputModel markNotificationAsReadInputModel,
  });
}
