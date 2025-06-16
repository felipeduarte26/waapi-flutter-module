import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/enums/facial_recognition_status_enum.dart';
import '../../../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../../core/domain/usecases/check_need_facial_recognition_by_clocking_event_use_usecase.dart';
import '../../../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../../../core/infra/utils/enum/execution_mode_enum.dart';
import '../../../../../facial_recognition/domain/usecases/get_facial_recognition_failure_reason_usecase.dart';
import '../../../../../routes/collector_routes.dart';
import '../../../../domain/usecase/call_facial_recognition_config_usecase.dart';
import 'register_validation_node.dart';

class GetFacialRecognitionStateNode extends RegisterValidationNode {
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final ICheckNeedFacialRecognitionByClockingEventTypeUsecase
      _checkNeedFacialRecognitionByClockingEventTypeUsecase;
  final ICallFacialRecognitionConfigUsecase _callFacialRecognitionConfigUsecase;
  final GetFacialRecognitionFailureReasonUsecase
      _getFacialRecognitionFailureReasonUsecase;
  final IPermissionService _permissionService;
  final NavigatorService _navigatorService;
  final LogService _logService;
  late RegisterClockingEventBloc _registerClockingEventBloc;

  GetFacialRecognitionStateNode({
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required ICheckNeedFacialRecognitionByClockingEventTypeUsecase
        checkNeedFacialRecognitionByClockingEventTypeUsecase,
    required ICallFacialRecognitionConfigUsecase
        callFacialRecognitionConfigUsecase,
    required GetFacialRecognitionFailureReasonUsecase
        getFacialRecognitionFailureReasonUsecase,
    required IPermissionService permissionService,
    required NavigatorService navigatorService,
    required LogService logService,
  })  : _getExecutionModeUsecase = getExecutionModeUsecase,
        _checkNeedFacialRecognitionByClockingEventTypeUsecase =
            checkNeedFacialRecognitionByClockingEventTypeUsecase,
        _callFacialRecognitionConfigUsecase =
            callFacialRecognitionConfigUsecase,
        _getFacialRecognitionFailureReasonUsecase =
            getFacialRecognitionFailureReasonUsecase,
        _permissionService = permissionService,
        _navigatorService = navigatorService,
        _logService = logService;

  FacialRecognitionStatusEnum? facialRecognitionStatus;

  void setContext(
    RegisterClockingEventBloc registerClockingEventBloc,
  ) {
    _registerClockingEventBloc = registerClockingEventBloc;
  }

  @override
  Future<dynamic> handler() async {
    DateTime initDateTime = DateTime.now();
    log('##INFO## GetFacialRecognitionStateNode started ${DateTime.now()}');
    final ExecutionModeEnum executionModeEnum =
        await _getExecutionModeUsecase.call();

    final needFacialRecognition =
        _checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
      clockingEventRegisterType: _registerClockingEventBloc
          .clockingEventRegisterEntity.clockingEventRegisterType,
    );

    if (executionModeEnum.isIndividualOrDriver() && needFacialRecognition) {
      DevicePermissionEnum permissionType = DevicePermissionEnum.camera;
      PermissionStatus permissionStatus =
          await _permissionService.check(permission: permissionType);

      if (permissionStatus.isGranted) {
        final bool callFacialRecognition =
            await _callFacialRecognitionConfigUsecase.call();
        if (callFacialRecognition) {
          _logService.saveLocalLog(
            exception: 'GetFacialRecognitionStateNode',
            stackTrace:
                'ExecutionMode: ${executionModeEnum.name}, Validating facial recognition at ${DateTime.now()}',
          );

          facialRecognitionStatus = await getFacialRecognition();
        }
      }
      _registerClockingEventBloc
              .clockingEventRegisterEntity.facialRecognitionStatus =
          facialRecognitionStatus ??
              await _getFacialRecognitionFailureReasonUsecase.call();
    }

    _logService.saveLocalLog(
      exception: 'GetFacialRecognitionStateNode',
      stackTrace:
          'Face Recognition Success: ${_registerClockingEventBloc.clockingEventRegisterEntity.successFacialRecognition}, at ${DateTime.now()}',
    );

    log('##INFO## GetFacialRecognitionStateNode finished ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetFacialRecognitionStateNode: #ProcessingTime: ${totalDuration.toString()}');
    return super.handler();
  }

  Future<FacialRecognitionStatusEnum?> getFacialRecognition() async {
    FacialRecognitionStatusEnum? faceRecognitionResult =
        await _navigatorService.pushNamed(
      route:
          '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.recognitionFull}',
    );

    if (faceRecognitionResult != null) {
      if (faceRecognitionResult ==
          FacialRecognitionStatusEnum.successfullyRecognized) {
        _registerClockingEventBloc
            .clockingEventRegisterEntity.successFacialRecognition = true;
        _registerClockingEventBloc
                .clockingEventRegisterEntity.clockingEventRegisterType =
            ClockingEventRegisterTypeFacialRecognition(
          employeeId: _registerClockingEventBloc
              .clockingEventRegisterEntity.employeeDto!.id,
        );
      }
      return faceRecognitionResult;
    }
    return null;
  }
}
