import 'dart:developer';
import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
    
import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/entities/clocking_event_use.dart';
import '../../../../core/domain/entities/configuration.dart';
import '../../../../core/domain/enums/clocking_event_use_type.dart';
import '../../../../core/domain/enums/network_status.dart';
import '../../../../core/domain/enums/operation_mode_type.dart';
import '../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../core/domain/input_model/clocking_event_use_dto.dart';
import '../../../../core/domain/input_model/configuration_dto.dart';
import '../../../../core/domain/input_model/device_info_dto.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/input_model/synchronization_result.dart';
import '../../../../core/domain/repositories/database/clocking_event_use_repository.dart';
import '../../../../core/domain/usecases/get_access_token_usecase.dart';
import '../../../../core/external/mappers/clocking_event_use_mapper.dart';
import '../../../../core/external/mappers/company_mapper.dart';
import '../../../../core/external/mappers/configuration_mapper.dart';
import '../../../../core/external/mappers/employee_mapper.dart';
import '../../../../core/infra/utils/enum/synchronization_enum.dart';

class RegisterClockingEventService implements IRegisterClockingEventService {
  final IPlatformService _platformService;
  final clock.ICreateClockingEventService _createClockingEventService;
  final IClockingEventRepository _clockingEventRepository;
  final ISynchronizeClockingEventService _synchronizeClockingEventService;
  final IEnvironmentService _environmentService;
  final IUtils _utils;
  final clock.IInternalClockService _internalClockService;
  final IConfigurationRepository _configurationRepository;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final ClockingEventUseRepository _clockingEventUseRepository;
  final LogService _logService;

  const RegisterClockingEventService({
    required IPlatformService platformService,
    required clock.ICreateClockingEventService createClockingEventService,
    required IClockingEventRepository clockingEventRepository,
    required ISynchronizeClockingEventService synchronizeClockingEventService,
    required IEnvironmentService environmentService,
    required IUtils utils,
    required clock.IInternalClockService internalClockService,
    required IConfigurationRepository configurationRepository,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required ClockingEventUseRepository clockingEventUseRepository,
    required LogService logService,
  })  : _platformService = platformService,
        _createClockingEventService = createClockingEventService,
        _clockingEventRepository = clockingEventRepository,
        _synchronizeClockingEventService = synchronizeClockingEventService,
        _environmentService = environmentService,
        _utils = utils,
        _internalClockService = internalClockService,
        _configurationRepository = configurationRepository,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _clockingEventUseRepository = clockingEventUseRepository,
        _logService = logService;

  @override
  Future<clock.ImportClockingEventDto> register({
    required ClockingEventRegisterEntity clockingEventRegisterEntity,
  }) async {
    DateTime dateTimeThatClockingEventProcessStarted =
        clockingEventRegisterEntity.dateTime;
    StateLocationEntity location = clockingEventRegisterEntity.location!;
    StatePhotoEntity? photo = clockingEventRegisterEntity.photo;
    EmployeeDto employeeDto = clockingEventRegisterEntity.employeeDto!;

    
    Configuration? configEntity =  await _configurationRepository.findByEmployeeId(
      employeeId: employeeDto.id,
    );
    ConfigurationDto? employeeConfiguration = ConfigurationMapper.fromEntityToDtoCollector(configEntity);
    final clockingEventRegisterType =
        clockingEventRegisterEntity.clockingEventRegisterType;

    OperationModeType mode = _utils.getOperationModeEnum(
      registerType: clockingEventRegisterType,
    );

    NetworkStatusEnum networkStatusEnum =
        await _platformService.connectivityStatus();

    List<ClockingEventUse> clockingUseListEntity =
        await _clockingEventUseRepository.findAllByEmployeeId(
      employeeId: employeeDto.id,
    );
    List<ClockingEventUseDto> clockingUseList = ClockingEventUseMapper.fromEntityToDtoCollectorList(clockingUseListEntity)!;
  
    ClockingEventUseType clockingEventType =
        ClockingEventUseType.clockingEvent;

    if (mode == OperationModeType.driver) {
      var clockingEventUse =
          (clockingEventRegisterType as ClockingEventRegisterTypeDriver)
              .clockingEventUse;
      clockingEventType = clockingEventUse;
      
    }
    auth.ClockingEventUseType authClockingEventType = auth.ClockingEventUseType.build(clockingEventType.value);

    auth.ClockingEventUseDTO? clockingEventUseDTO = ClockingEventUseMapper.fromDtoCollectorToAuthList(
      clockingUseList,)
        .where(
          (element) => element.clockingEventUseType == authClockingEventType,
        )
        .firstOrNull;

    clock.ClockingEventInformationDto infoDto =
        clock.ClockingEventInformationDto(
      platform: _platformService.getPlatformDevice(),
      clockingEventUse: int.parse(
        clockingEventUseDTO?.code ??
            clock.ClockingEventUseEnum.clockingEvent.codigo.toString(),
      ),
      appVersion: (await _platformService.getPackageinfo()).version,
      networkStatus: clock.NetworkStatusEnum.build(networkStatusEnum.value),
      mode: clock.OperationModeEnum.build(mode.value),
      origin: clock.ClockingEventOriginEnum.mobile,
      geolocation: await toLocationDto(location),
      appointmentImage: photo?.name,
      imageNotCapturedReason: _imageNotCapturedReason(photo),
      geolocationIsMock: location.isMock,
      locationStatus: _locationStatus(location),
      timeZone: employeeConfiguration!.timezone,
      facialRecognitionStatus: clockingEventRegisterEntity.facialRecognitionStatus == null
          ? null
          :
         clock.FacialRecognitionStatusEnum.build(clockingEventRegisterEntity.facialRecognitionStatus!.value),
    );

    DeviceInfo devicInfo = await _platformService.getDeviceInfoDto();

    clock.DeviceDto device = clock.DeviceDto(
      imei: devicInfo.identifier,
      name: devicInfo.name,
      developerMode: await _getDevelopmentMode(),
      gpsOperationMode: location.hasPermission
          ? clock.GPSoperationModeEnum.active
          : clock.GPSoperationModeEnum.inactive,
      dateTimeAutomatic: await _platformService.isTimeAuto(),
      timeZoneAutomatic: await _platformService.isTimeZoneAuto(),
    );

    /// Call clocking event service
    clock.ImportClockingEventDto clockingEvent =
        await _createClockingEventService.createClockingEvent(
      company: CompanyMapper.fromCollectorDtoToClock(employeeDto.company)!,
      employee: EmployeeMapper.fromCollectorDtoToClock(employeeDto)!,
      clockInfo: infoDto,
      dateTimeThatClockingEventProcessStarted:
          dateTimeThatClockingEventProcessStarted,
      device: device,
    );

    clockingEvent = await _setPhotoName(clockingEvent);

    /// Save regiter in local database
   bool saved = await _clockingEventRepository.save(
      clockingEvent: clockingEvent,
      journeyId: clockingEventRegisterEntity.journeyId,
      isMealBreak: clockingEventRegisterEntity.isMealBreak ?? false,
      journeyEventName: clockingEventRegisterEntity.journeyEventName,
    );

    if (!saved) {
      _logService.saveLocalLog(
        exception: 'RegisterClockingEventService',
        stackTrace: 'ClockingEvent not save ${clockingEvent.toString()}',
        importClockingEvent: clockingEvent,
        dateTimeOnDevice: DateTime.now(),
      );
    } else {
      _logService.saveLocalLog(
        exception: 'TraceRouteLog',
        stackTrace: 'Saved clocking event on the device',
        importClockingEvent: clockingEvent,
        dateTimeOnDevice: DateTime.now(),
      );
    }

    log('RegisterClockingEventService: Reconhecimento Facial: Marcação de ponto realizada com sucesso${clockingEvent.timeEvent}');

    bool hasToken = (await _getAccessTokenUsecase.call()) != null;
    if (hasToken) {
      /// Se for modo marcação por usuário e senha no modo multiplo,
      /// aguarda a sincronização pois o usuário será desautenticado ficando assim sem token.
      if (networkStatusEnum == NetworkStatusEnum.active &&
          clockingEventRegisterEntity.clockingEventRegisterType
              is clock.ClockingEventRegisterTypeEmailPassword) {
        try {
          await _synchronizeClockingEventService.startSynchronize();
        } catch (e) {
          log('RegisterClockingEventService: Erro ao sincronizar marcação de ponto: $e');
          _logService.saveLocalLog(
            exception: 'RegisterClockingEventService',
            stackTrace: 'Sync error: ${clockingEvent.toString()}, Error message: $e',
            dateTimeOnDevice: DateTime.now(),
          );
        }
      } else {
        SynchronizationResult synchronizationResult = await _synchronizeClockingEventService.startSynchronize();

        if (synchronizationResult.status != SynchronizationStatus.success) {
          _logService.saveLocalLog(
            exception: 'SynchronizationResult',
            stackTrace: 'Sync error: ${synchronizationResult.toString()}, Message: ${synchronizationResult.message.message}',
            dateTimeOnDevice: DateTime.now(),
          );
        }
      }
    }

    return clockingEvent;
  }

  Future<clock.LocationDTO?> toLocationDto(StateLocationEntity location) async {
    if (!location.success) {
      return null;
    }

    clock.LocationDTO locationDto = clock.LocationDTO(
      latitude: location.latitude!,
      longitude: location.longitude!,
      dateAndTime: _internalClockService.getClockDateTime(),
    );

    return Future.value(locationDto);
  }

  Future<clock.ImportClockingEventDto> _setPhotoName(
    clock.ImportClockingEventDto clockingEvent,
  ) async {
    if (clockingEvent.appointmentImage == null) {
      return clockingEvent;
    }

    String newPhotoName =
        '${clockingEvent.dateEvent}T${clockingEvent.timeEvent}${clockingEvent.timeZone}.jpg';

    String oldPath = await _utils.createPhotoPath(
      employeeId: clockingEvent.employeeId,
      photoName: clockingEvent.appointmentImage!,
    );

    String newPath = await _utils.createPhotoPath(
      employeeId: clockingEvent.employeeId,
      photoName: newPhotoName,
    );

    if (_environmentService.environment() != EnvironmentEnum.test) {
      File oldFile = File(oldPath);
      await oldFile.rename(newPath);
    }

    clockingEvent.appointmentImage = newPhotoName;
    return clockingEvent;
  }

  clock.LocationStatusEnum? _locationStatus(StateLocationEntity location) {
    if (location.success) {
      return clock.LocationStatusEnum.location;
    }

    if (!location.hasPermission) {
      return clock.LocationStatusEnum.noLocationPermission;
    }

    return clock.LocationStatusEnum.noLocation;
  }

  clock.ImageNotCapturedReasonEnum? _imageNotCapturedReason(
    StatePhotoEntity? photo,
  ) {
    if (photo == null || photo.success) {
      return null;
    }

    if (!photo.hasPermission) {
      return clock.ImageNotCapturedReasonEnum.notAllowed;
    }

    return clock.ImageNotCapturedReasonEnum.canceled;
  }

  Future<clock.DeveloperModeEnum> _getDevelopmentMode() async {
    return (await _platformService.isDevelopmentDevice())
        ? clock.DeveloperModeEnum.active
        : clock.DeveloperModeEnum.inactive;
  }
}
