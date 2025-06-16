import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/types/either.dart';
import '../../../clocking_event/domain/usecase/get_employee_usecase.dart';
import '../entities/has_unread_push_message_entity.dart';
import '../failures/notification_failure.dart';
import '../repositories/get_number_unread_notifications_repository.dart';

abstract class GetNumberUnreadNotificationsUsecase {
  Future<HasUnreadPushMessageEntity> call();
}

class GetNumberUnreadNotificationsUsecaseImpl
    implements GetNumberUnreadNotificationsUsecase {
  final GetNumberUnreadNotificationsRepository
      _getNumberUnreadNotificationsRepository;
  IGetEmployeeUsecase? getEmployeeUsecase;

  GetNumberUnreadNotificationsUsecaseImpl({
    required GetNumberUnreadNotificationsRepository
        getNumberUnreadNotificationsRepository,
    this.getEmployeeUsecase,
  }) : _getNumberUnreadNotificationsRepository =
            getNumberUnreadNotificationsRepository;

  @override
  Future<HasUnreadPushMessageEntity> call() async {
    EmployeeDto? employeeDto = getEmployeeUsecase?.call();

    if (employeeDto != null) {
      Either<NotificationFailure, HasUnreadPushMessageEntity> callback =
          await _getNumberUnreadNotificationsRepository.call(
        employeeId: employeeDto.id,
      );

      return callback.fold(
        (left) => HasUnreadPushMessageEntity(
          hasUnreadPushMessage: false,
          number: 0,
        ),
        (right) => right,
      );
    }

    return HasUnreadPushMessageEntity(
      hasUnreadPushMessage: false,
      number: 0,
    );
  }
}
