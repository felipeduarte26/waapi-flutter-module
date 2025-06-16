import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';

import '../../../../../../../ponto_mobile_collector.dart';
import '../../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../../core/external/mappers/clocking_event_mapper.dart';
import '../../../domain/usecase/get_clock_time_usecase.dart';
import '../../../domain/usecase/register_clocking_event_usecase.dart';
import 'register_validation_chain/get_camera_permission_node.dart';
import 'register_validation_chain/get_employee_node.dart';
import 'register_validation_chain/get_facial_recognition_state_node.dart';
import 'register_validation_chain/get_fence_status_state_node.dart';
import 'register_validation_chain/get_location_permission_node.dart';
import 'register_validation_chain/get_location_state_node.dart';
import 'register_validation_chain/get_photo_state_node.dart';
import 'register_validation_chain/get_recent_status_state_node.dart';
import 'register_validation_chain/get_reminder_status_state_node.dart';

class RegisterClockingEventBloc
    extends Bloc<RegisterClockingEventEvent, RegisterClockingState> {
  late final IRegisterClockingEventUsecase _registerClockingEventUsecase;
  late final IGetClockDateTimeUsecase _getClockDateTimeUsecase;
  late final GetReminderStatusStateNode _getReminderStatusStateNode;
  late final GetRecentStatusStateNode _getRecentStatusStateNode;
  late final GetLocationStateNode _getLocationStateNode;
  late final GetFenceStatusStateNode _getFenceStatusStateNode;
  late final GetFacialRecognitionStateNode _getFacialRecognitionStateNode;
  late final GetPhotoStateNode _getPhotoStateNode;
  late final GetEmployeeNode _getEmployeeNode;
  late final GetLocationPermissionNode _getLocationPermissionNode;
  late final GetCameraPermissionNode _getCameraPermissionNode;
  final LogService _logService;

  @visibleForTesting
  bool get isUnitTesting => Platform.environment.containsKey('FLUTTER_TEST');

  late ClockingEventRegisterEntity clockingEventRegisterEntity;
  bool isRegistering = false;
  Lock lock = Lock();

  RegisterClockingEventBloc({
    required IRegisterClockingEventUsecase registerClockingEventUsecase,
    required IGetClockDateTimeUsecase getClockDateTimeUsecase,
    required GetRecentStatusStateNode getRecentStatusStateNode,
    required GetLocationStateNode getLocationStateNode,
    required GetFenceStatusStateNode getFenceStatusStateNode,
    required GetFacialRecognitionStateNode getFacialRecognitionStateNode,
    required GetPhotoStateNode getPhotoStateNode,
    required GetEmployeeNode getEmployeeNode,
    required GetLocationPermissionNode getLocationPermissionNode,
    required GetCameraPermissionNode getCameraPermissionNode,
    required GetReminderStatusStateNode getReminderStatusStateNode,
    required LogService logService,
  })  : _registerClockingEventUsecase = registerClockingEventUsecase,
        _getClockDateTimeUsecase = getClockDateTimeUsecase,
        _getRecentStatusStateNode = getRecentStatusStateNode,
        _getLocationStateNode = getLocationStateNode,
        _getFenceStatusStateNode = getFenceStatusStateNode,
        _getFacialRecognitionStateNode = getFacialRecognitionStateNode,
        _getPhotoStateNode = getPhotoStateNode,
        _getEmployeeNode = getEmployeeNode,
        _getLocationPermissionNode = getLocationPermissionNode,
        _getCameraPermissionNode = getCameraPermissionNode,
        _getReminderStatusStateNode = getReminderStatusStateNode,
        _logService = logService,
        super(initialRegisterClockingEventState) {
    on<NewRegisterEvent>((event, emit) async {
      DateTime initDateTime = DateTime.now();
      await lock.synchronized(() async {
        isUnitTesting
            ? null
            : clockingEventRegisterEntity = ClockingEventRegisterEntity(
                dateTime: _getClockDateTimeUsecase.call(),
                clockingEventRegisterType: event.clockingEventRegisterType,
              );
        emit(RegisterClockingInProgressState());
        emit(
          await doRegister(event),
        );
      });

      Duration totalDuration = DateTime.now().difference(initDateTime);
      log('RegisterClockingEventBloc: #ProcessingTime #TotalTime: ${totalDuration.toString()}');
    });
  }

  void setContext({required BuildContext context}) {
    _getEmployeeNode.setContext(this);
    _getRecentStatusStateNode.setContext(context, this);
    _getLocationStateNode.setContext(this);
    _getFenceStatusStateNode.setContext(context, this);
    _getFacialRecognitionStateNode.setContext(this);
    _getPhotoStateNode.setContext(this);
    _getLocationPermissionNode.setContext(context);
    _getCameraPermissionNode.setContext(context);
    _getReminderStatusStateNode.setContext(context, this);
  }

  void setClockingEventRegisterEntity({
    required ClockingEventRegisterEntity registerEntity,
  }) {
    clockingEventRegisterEntity = registerEntity;
  }

  Future<RegisterClockingState> doRegister(NewRegisterEvent event) async {
    log('##INFO## Stating clocking event register: ${DateTime.now()}');
    _logService.saveLocalLog(exception: 'TraceRouteLog', stackTrace: 'Starting clocking event register', dateTimeOnDevice: DateTime.now());
    isRegistering = true;

    if (event.stateLocationEntity != null) {
      clockingEventRegisterEntity.location = event.stateLocationEntity;
    }

    var clockingEventRegisterType = event.clockingEventRegisterType;
    if (clockingEventRegisterType is ClockingEventRegisterTypeDriver) {
      clockingEventRegisterEntity.journeyId =
          clockingEventRegisterType.journeyId;
      clockingEventRegisterEntity.isMealBreak =
          clockingEventRegisterType.isMealBreak;
      clockingEventRegisterEntity.journeyEventName = clockingEventRegisterType.journeyEventName;
    }

    /// Ordem de execução dos nós
    _getLocationPermissionNode.setNextNode(_getCameraPermissionNode);
    _getCameraPermissionNode.setNextNode(_getEmployeeNode);
    _getEmployeeNode.setNextNode(_getRecentStatusStateNode);
    _getRecentStatusStateNode.setNextNode(_getReminderStatusStateNode);
    _getReminderStatusStateNode.setNextNode(_getLocationStateNode);
    _getLocationStateNode.setNextNode(_getFenceStatusStateNode);
    _getFenceStatusStateNode.setNextNode(_getFacialRecognitionStateNode);
    _getFacialRecognitionStateNode.setNextNode(_getPhotoStateNode);

    bool? successExecutionNodes = await _getLocationPermissionNode.handler();

    if (successExecutionNodes != null && !successExecutionNodes) {
      isRegistering = false;
      return RegistrationCanceledState();
    }
      
    ClockingEventDto clockingEventDto =
        await _registerClockingEventUsecase.call(
      clockingEventRegisterEntity: clockingEventRegisterEntity,
    );


    isRegistering = false;
    _logService.saveLocalLog(exception: 'TraceRouteLog', stackTrace: 'Finish clocking event register', dateTimeOnDevice: DateTime.now());
    log('##INFO## Finish clocking event register at ${DateTime.now()}');

    return SuccessRegisterState(clockingEvent: ClockingEventMapper.fromDtoToEntityCollector(clockingEventDto)!);
  }
}
