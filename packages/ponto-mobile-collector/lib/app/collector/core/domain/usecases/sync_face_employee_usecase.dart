import '../../../../../ponto_mobile_collector.dart';
import '../../infra/utils/enum/synchronization_enum.dart';
import '../enums/work_indicator_type.dart';
import '../input_model/synchronization_result.dart';
import '../repositories/face_recognition_check_face_repository.dart';
import '../repositories/face_recognition_register_company_repository.dart';
import '../services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import '../services/work_indicator_service.dart';

/// Synchronizes the face of the logged-in employee
abstract class ISyncFaceEmployeeUsecase {
  Future<SynchronizationResult> call();
}

class SyncFaceEmployeeUsecase implements ISyncFaceEmployeeUsecase {
  final IFaceRecognitionSdkAuthenticationService
      _faceRecognitionSdkAuthenticationService;
  final ISharedPreferencesService _sharedPreferencesService;
  final ISessionService _sessionService;
  final FaceRecognitionRegisterCompanyRepository
      _faceRecognitionRegisterCompanyRepository;
  final FaceRecognitionCheckFaceRepository _faceRecognitionCheckFaceRepository;
  final WorkIndicatorService _workIndicatorService;

  final WorkIndicatorType workIndicatorType =
      WorkIndicatorType.syncFaceEmployeeUsecase;

  const SyncFaceEmployeeUsecase({
    required IFaceRecognitionSdkAuthenticationService
        faceRecognitionSdkAuthenticationService,
    required ISharedPreferencesService sharedPreferencesService,
    required ISessionService sessionService,
    required FaceRecognitionRegisterCompanyRepository
        faceRecognitionRegisterCompanyRepository,
    required FaceRecognitionCheckFaceRepository
        faceRecognitionCheckFaceRepository,
    required WorkIndicatorService workIndicatorService,
  })  : _faceRecognitionSdkAuthenticationService =
            faceRecognitionSdkAuthenticationService,
        _sharedPreferencesService = sharedPreferencesService,
        _sessionService = sessionService,
        _faceRecognitionRegisterCompanyRepository =
            faceRecognitionRegisterCompanyRepository,
        _faceRecognitionCheckFaceRepository =
            faceRecognitionCheckFaceRepository,
        _workIndicatorService = workIndicatorService;

  @override
  Future<SynchronizationResult> call() async {
    _workIndicatorService.addWorkIndicator(
      workIndicatorType: workIndicatorType,
    );

    SynchronizationResult synchronizationResult = SynchronizationResult(
      SynchronizationStatus.error,
      SynchronizationMessage.syncClockingEventSyncSuccess,
    );

    if (_sessionService.hasEmployee()) {
      String employeeId = _sessionService.getEmployeeId();
      bool employeeHasFaceRegistered =
          _sessionService.getEmployee().faceRegistered != null;
      if (!employeeHasFaceRegistered) {
        _workIndicatorService.removeWorkIndicator(
          workIndicatorType: workIndicatorType,
        );

        return SynchronizationResult(
          SynchronizationStatus.success,
          SynchronizationMessage.noFaceRegistered,
        );
      }

      bool faceSynced = await _faceRecognitionCheckFaceRepository.call(
        employeeId: employeeId,
      );

      if (!faceSynced) {
        String companyId = _sessionService.getCompanyId();
        bool facialRecognitionAuthentication =
            await _sharedPreferencesService.getFacialRecognitionAuthentication(
          companyId: companyId,
        );

        if (!facialRecognitionAuthentication) {
          _faceRecognitionRegisterCompanyRepository.call(companyId: companyId);
        }

        if (facialRecognitionAuthentication) {
          bool registeredBiometricFace =
              _sessionService.getEmployee().faceRegistered ==
                  employeeId.replaceAll('-', '');

          if (registeredBiometricFace) {
            _faceRecognitionSdkAuthenticationService.initialize(
              delayToInit: const Duration(seconds: 30),
            );

            _workIndicatorService.removeWorkIndicator(
              workIndicatorType: workIndicatorType,
            );

            return SynchronizationResult(
              SynchronizationStatus.success,
              SynchronizationMessage.syncClockingEventSyncSuccess,
            );
          }
        } else {
          _workIndicatorService.removeWorkIndicator(
            workIndicatorType: workIndicatorType,
          );

          return SynchronizationResult(
            SynchronizationStatus.success,
            SynchronizationMessage.syncClockingEventSyncFailure,
          );
        }
      } else {
        _workIndicatorService.removeWorkIndicator(
          workIndicatorType: workIndicatorType,
        );

        return SynchronizationResult(
          SynchronizationStatus.success,
          SynchronizationMessage.syncClockingEventSyncSuccess,
        );
      }
    }

    _workIndicatorService.removeWorkIndicator(
      workIndicatorType: workIndicatorType,
    );

    return synchronizationResult;
  }
}
