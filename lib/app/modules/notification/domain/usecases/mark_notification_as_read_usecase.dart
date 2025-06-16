import '../../../../core/types/either.dart';
import '../failures/notification_failure.dart';
import '../input_models/mark_notification_as_read_input_model.dart';
import '../repositories/mark_notification_as_read_repository.dart';
import '../types/notification_domain_types.dart';

abstract class MarkNotificationAsReadUsecase {
  MarkNotificationAsReadCallback call({
    required MarkNotificationAsReadInputModel markNotificationAsReadInputModel,
  });
}

class MarkNotificationAsReadUsecaseImpl implements MarkNotificationAsReadUsecase {
  final MarkNotificationAsReadRepository _notificationAsReadRepository;

  const MarkNotificationAsReadUsecaseImpl({
    required MarkNotificationAsReadRepository notificationAsReadRepository,
  }) : _notificationAsReadRepository = notificationAsReadRepository;

  @override
  MarkNotificationAsReadCallback call({
    required MarkNotificationAsReadInputModel markNotificationAsReadInputModel,
  }) async {
    if (markNotificationAsReadInputModel.notificationId.isEmpty) {
      return left(const MarkNotificationAsReadRequirementsFailure());
    }

    return _notificationAsReadRepository.call(
      markNotificationAsReadInputModel: markNotificationAsReadInputModel,
    );
  }
}
