import '../../../../../ponto_mobile_collector.dart';
import '../enums/work_indicator_type.dart';
import '../repositories/face_recognition_sync_face_repository.dart';
import '../services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import '../services/work_indicator_service.dart';

abstract class ISyncMultipleFaceEmployeesUsecase {
  Future<bool> call({Duration delayToInit = Duration.zero});
}

class SyncMultipleFaceEmployeesUsecase
    implements ISyncMultipleFaceEmployeesUsecase {
  final FaceRecognitionSyncFaceRepository _faceRecognitionSyncFaceRepository;
  final IEmployeeRepository _employeeRepository;
  final LogService _logService;
  final WorkIndicatorService _workIndicatorService;
  final WorkIndicatorType workIndicatorType =
      WorkIndicatorType.syncMultipleFaceEmployees;
  final IFaceRecognitionSdkAuthenticationService
      _faceRecognitionSdkAuthenticationService;

  const SyncMultipleFaceEmployeesUsecase({
    required FaceRecognitionSyncFaceRepository
        faceRecognitionSyncFaceRepository,
    required IEmployeeRepository employeeRepository,
    required LogService logService,
    required WorkIndicatorService workIndicatorService,
    required IFaceRecognitionSdkAuthenticationService
        faceRecognitionSdkAuthenticationService,
  })  : _faceRecognitionSyncFaceRepository = faceRecognitionSyncFaceRepository,
        _employeeRepository = employeeRepository,
        _logService = logService,
        _workIndicatorService = workIndicatorService,
        _faceRecognitionSdkAuthenticationService =
            faceRecognitionSdkAuthenticationService;

  @override
  Future<bool> call({Duration delayToInit = Duration.zero}) async {
    _workIndicatorService.addWorkIndicator(
      workIndicatorType: workIndicatorType,
    );

    await Future.delayed(delayToInit);

    // TODO Validar se a configuração do dispositivo possui a configuração de reconheicmento facial para realizar a ação de sincroniza.
    var findByFaceRegisteredNotEmpty =
        await _employeeRepository.findByFaceRegisteredNotEmpty();
    var map =
        findByFaceRegisteredNotEmpty.map((e) => e!.faceRegistered!).toList();

    if (map.isEmpty) {
      _logService.saveLocalLog(
        exception: 'SyncMultipleFaceEmployeesUsecase',
        stackTrace: 'Not a face to sync at ${DateTime.now()}',
      );

      _workIndicatorService.removeWorkIndicator(
        workIndicatorType: workIndicatorType,
      );

      return true;
    }

    if (map.isNotEmpty) {
      /// Aguarda a inicialização do reconhecimento facial
      while (_faceRecognitionSdkAuthenticationService
          .getInitializationIsRunning()) {
        await Future.delayed(const Duration(seconds: 5));
      }
      
      bool syncResult =
          await _faceRecognitionSyncFaceRepository.call(employeesId: map);

      _logService.saveLocalLog(
        exception: 'SyncMultipleFaceEmployeesUsecase',
        stackTrace:
            'Employees to synchronize faces ${map.toString()} at ${DateTime.now()}',
      );

      _workIndicatorService.removeWorkIndicator(
        workIndicatorType: workIndicatorType,
      );

      return syncResult;
    }

    _workIndicatorService.removeWorkIndicator(
      workIndicatorType: workIndicatorType,
    );

    return false;
  }
}
