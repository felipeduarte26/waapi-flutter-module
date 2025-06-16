import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/enums/clocking_event_use_type.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import '../../../../core/domain/usecases/get_acess_token_username_usecase.dart';
import '../../../../core/domain/usecases/get_clocking_event_use_usecase.dart';
import '../../../../core/infra/utils/enum/user_action_enum.dart';
import '../../../../core/infra/utils/enum/user_resource_enum.dart';

abstract class ShowFaceRegistrationMessageUsecase {
  Future<bool> call(String? clockingEventUse);
}

class ShowFaceRegistrationMessageUsecaseImpl
    implements ShowFaceRegistrationMessageUsecase {
  final ISharedPreferencesService sharedPreferencesService;
  final ISessionService sessionService;
  final IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  final GetAccessTokenUsernameUsecase getAccessTokenUsernameUsecase;
  final GetClockingEventUseUsecase getClockingEventUseUsecase;

  const ShowFaceRegistrationMessageUsecaseImpl({
    required this.sharedPreferencesService,
    required this.sessionService,
    required this.faceRecognitionSdkAuthenticationService,
    required this.getAccessTokenUsernameUsecase,
    required this.getClockingEventUseUsecase,
  });

  @override
  Future<bool> call(String? clockingEventUse) async {
    bool notShowMessage = false;

    if (!sessionService.hasEmployee()) {
      return notShowMessage;
    }

    EmployeeDto employee = sessionService.getEmployee();
    var userIdentifier = await getAccessTokenUsernameUsecase.call();

    if (employee.faceRegistered == employee.id.replaceAll('-', '')) {
      return notShowMessage;
    }

    bool faceRecognitionEnable =
        sessionService.getConfiguration().faceRecognition ?? false;

    if (!faceRecognitionEnable) {
      return notShowMessage;
    }

    bool facialAuthPermission =
        await sharedPreferencesService.getUserPermission(
      userName: userIdentifier!,
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.facialAuth.resource,
    );

    if (clockingEventUse != null) {
      var clockingEventUseType =
          await getClockingEventUseUsecase.call(clockingEventUse, employee.id);

      if (clockingEventUseType != ClockingEventUseType.clockingEvent) {
        return notShowMessage;
      }
    }

    return !faceRecognitionSdkAuthenticationService
            .getInitializationIsRunning() &&
        facialAuthPermission;
  }
}
