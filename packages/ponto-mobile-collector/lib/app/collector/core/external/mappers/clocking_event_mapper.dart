import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import '../../domain/entities/clocking_event.dart';
import '../../domain/enums/clocking_event_origin.dart';
import '../../domain/enums/location_status.dart';
import '../../domain/enums/operation_mode_type.dart';
import '../../domain/input_model/clocking_event_dto.dart';
import '../../domain/input_model/clocking_event_use_dto.dart';
import '../../domain/input_model/company_dto.dart';
import '../../domain/input_model/employee_dto.dart';
import '../../domain/input_model/location_dto.dart';
import '../../domain/repositories/database/icompany_repository.dart';
import '../../domain/repositories/database/iemployee_repository.dart';
import 'company_mapper.dart';
import 'device_mapper.dart';
import 'employee_mapper.dart';

class ClockingEventMapper {
  final IEmployeeRepository _employeeRepository;
  final ICompanyRepository _companyRepository;

  ClockingEventMapper(
    this._employeeRepository,
    this._companyRepository,
  );

  static clock.ImportClockingEventDto fromCollectorDtoToClock(
    ClockingEventDto dto,
  ) {
    return clock.ImportClockingEventDto(
      clockingEventId: dto.clockingEventId,
      dateEvent: dto.dateEvent,
      timeEvent: dto.timeEvent,
      timeZone: dto.timeZone,
      appVersion: dto.appVersion,
      platform: dto.platform,
      clientOriginInfo: dto.clientOriginInfo,
      device: DeviceMapper.fromCollectorDtoToClock(dto.device),
      fenceState: dto.fenceState != null ? clock.FenceStatusEnum.build(dto.fenceState.toString()): null,
      geolocation: LocationDto.fromCollectorDtoToClock(dto.geolocation),
      geolocationIsMock:
          false, // ### TO DO: ver para que server esta propriedade
      appointmentImage: dto.appointmentImage,
      photoNotCaptured: dto.photoNotCaptured,
      isSynchronized: dto.isSynchronized,
      mode: dto.mode != null ?clock.OperationModeEnum.build(dto.mode!.value): null,
      online: dto.online,
      origin: dto.origin != null? clock.ClockingEventOriginEnum.build(
        dto.origin!.value,
      ): null,
      companyIdentifier: dto.companyIdentifier,
      employeeId: getEmployeId(dto.employeeDto),
      use: int.parse(dto.use), // TO DO: verificar se está certo
      signature: dto.signature,
      signatureVersion: dto.signatureVersion,
      facialRecognitionStatus: dto.facialRecognitionStatus,
      cpf: dto.cpf,
    );
  }

  //-----------------------------------------------------------------------------

  static ClockingEvent? fromDtoToEntityCollector(ClockingEventDto? dto) {
    if (dto == null) {
      return null;
    }

    return ClockingEvent(
      id: dto.id ?? '',
      companyIdentifier: dto.companyIdentifier,
      dateEvent: dto.dateEvent,
      timeEvent: dto.timeEvent,
      timeZone: dto.timeZone,
      appVersion: dto.appVersion,
      platform: dto.platform,
      device: DeviceMapper.fromDtoToEntityCollector(dto.device),
      fenceState: dto.fenceState.toString(),
      isSynchronized: dto.isSynchronized,
      use: dto.use.toString(),
      signature: dto.signature,
      signatureVersion: dto.signatureVersion,
      facialRecognitionStatus: dto.facialRecognitionStatus,
      cpf: dto.cpf,
      employeeName: dto.employeeDto?.name ?? '',
      companyName: dto.companyDto?.name ?? '',
      appointmentImage: dto.appointmentImage,
      photoNotCaptured: dto.photoNotCaptured,
      mode: dto.mode.toString(),
      origin: dto.origin.toString(),
      online: dto.online,
      clientOriginInfo: dto.clientOriginInfo,
      isMealBreak: dto.isMealBreak ?? false,
      journeyEventName: dto.journeyEventName,
      location: dto.geolocation,
      locationStatus: dto.locationStatus, employeeId: dto.employeeDto?.id ?? '',
    );
  }

  Future<ClockingEventDto> fromEntityToDtoCollector(
      ClockingEvent entity,) async {
    return ClockingEventDto(
      clockingEventId: entity.id,
      companyIdentifier: entity.companyIdentifier,
      dateEvent: entity.dateEvent,
      timeEvent: entity.timeEvent,
      timeZone: entity.timeZone,
      appVersion: entity.appVersion ?? '',
      platform: entity.platform ?? '',
      device: DeviceMapper.fromEntityToDtoCollector(entity.device),
      fenceState: entity.fenceState,
      isSynchronized: entity.isSynchronized,
      use: 
          entity.use,
      signature: entity.signature,
      signatureVersion: entity.signatureVersion,
      facialRecognitionStatus: entity.facialRecognitionStatus,
      cpf: entity.cpf,
      employeeDto: await getEmployeeByCpf(entity.cpf),
      companyDto: await getCompanyByIdentifier(entity.companyIdentifier),
      id: entity.id,
      journeyEventName: entity.journeyEventName,
      locationStatus: entity.locationStatus,
      isMealBreak: entity.isMealBreak,
      geolocation: entity.location,
      appointmentImage: entity.appointmentImage,
      photoNotCaptured: entity.photoNotCaptured,
      mode: OperationModeType.build(entity.mode.toString()),
      online: entity.online,
      origin: ClockingEventOriginEnum.build(entity.origin.toString()),
      clientOriginInfo: entity.clientOriginInfo,
    );
  }

  Future<EmployeeDto?> getEmployeeByCpf(String cpf) async {
    var entity = await _employeeRepository.findByCpf(cpf: cpf);
    return EmployeeMapper.fromEntityToDtoCollector(entity);
  }

  Future<CompanyDto?> getCompanyByIdentifier(String companyIdentifier) async {
    var entity = await _companyRepository.findByIdentifier(
        identifier: companyIdentifier,);
    return CompanyMapper.fromEntityToDtoCollector(entity);
  }

  static String getEmployeId(EmployeeDto? employeeDto) {
    if (employeeDto == null) {
      return '';
    }
    return employeeDto.id;
  }

  Future<List<ClockingEventDto>> fromEntityToDtoCollectorList(
    List<ClockingEvent>? entityList,
  ) async {
    if (entityList == null || entityList.isEmpty) {
      return [];
    }
    List<ClockingEventDto> dtoList = [];
    for (var entity in entityList) {
      dtoList.add(await fromEntityToDtoCollector(entity));
    }
    return dtoList;
  }

  static ClockingEventDto fromClockToCollectorDto(
      clock.ImportClockingEventDto dtoClock,) {
    return ClockingEventDto(
      clockingEventId: dtoClock.clockingEventId,
      companyDto: CompanyMapper.fromClockToCollectorDto(dtoClock.companyDto),
      isMealBreak: dtoClock.isMealBreak,
      locationStatus: LocationStatusEnum.build(dtoClock.locationStatus!.id),
      id: dtoClock.clockingEventId,
      companyIdentifier: dtoClock.companyIdentifier,
      dateEvent: dtoClock.dateEvent,
      timeEvent: dtoClock.timeEvent,
      timeZone: dtoClock.timeZone,
      appVersion: dtoClock.appVersion,
      platform: dtoClock.platform,
      clientOriginInfo: dtoClock.clientOriginInfo,
      device: DeviceMapper.fromClockToCollectorDto(dtoClock.device),
      fenceState: dtoClock.fenceState.toString(),
      geolocation: LocationDto.fromClockToCollectorDto(dtoClock.geolocation),
      geolocationIsMock: false,
      appointmentImage: dtoClock.appointmentImage,
      photoNotCaptured: dtoClock.photoNotCaptured,
      isSynchronized: dtoClock.isSynchronized,
      mode: OperationModeType.build(dtoClock.mode!.id),
      online: dtoClock.online,
      origin: ClockingEventOriginEnum.build(dtoClock.origin!.value),
      employeeDto: EmployeeMapper.fromClockToCollectorDto(dtoClock.employeeDto),
      use: dtoClock.use.toString(),
      signature: dtoClock.signature,
      signatureVersion: dtoClock.signatureVersion,
      facialRecognitionStatus: dtoClock.facialRecognitionStatus,
      cpf: dtoClock.cpf,
    );
  }

  static List<auth.ClockingEventUseDTO> fromCollectorDtoToAuthList(
      {required List<ClockingEventUseDto> clockingUseList,}) {
    List<auth.ClockingEventUseDTO> list = [];
    for (var item in clockingUseList) {
      list.add(fromCollectorDtoToAuth(item));
    }
    return list;
  }

  static auth.ClockingEventUseDTO fromCollectorDtoToAuth(
      ClockingEventUseDto clockingEventUseDto,) {
    return auth.ClockingEventUseDTO(
      clockingEventUseType: auth.ClockingEventUseType.build(
          clockingEventUseDto.clockingEventUseType.value,),
      code: clockingEventUseDto.code,
      description: clockingEventUseDto.description,
      employeeId: clockingEventUseDto.employeeId,
    );
  }

  static List<clock.ImportClockingEventDto> fromCollectorDtoToClockList(List<ClockingEventDto> clockingEventListCollector) {
    List<clock.ImportClockingEventDto> list = [];
    for (var item in clockingEventListCollector) {
      list.add(fromCollectorDtoToClock(item));
    }
    return list;
  }

  static List<ClockingEvent> fromDtoToEntityCollectorList(List<ClockingEventDto> clockingEvents) {
    List<ClockingEvent> list = [];
    for (var item in clockingEvents) {
      list.add(fromDtoToEntityCollector(item)!);
    }
    return list;

  }

  static List<auth.ClockingEventUseDTO>?  fromDtoCollectorToAuthList(List<ClockingEventUseDto>? clockingUseList) {
    if (clockingUseList == null) {
      return [];
    }
    List<auth.ClockingEventUseDTO> list = [];
    for (var item in clockingUseList) {
      list.add(fromCollectorDtoToAuth(item));
    }
    return list;
  }

  static List<clock.ImportClockingEventDto> fromCollectorEntityToClock(List<ClockingEvent> entityList) {
    List<clock.ImportClockingEventDto> list = [];
    
    for (var item in entityList) {
      list.add(fromEntityToClock(item));
    }
    return list;
  }
  
  static clock.ImportClockingEventDto fromEntityToClock(ClockingEvent item) {
    
    return clock.ImportClockingEventDto(
      clockingEventId: item.id,
      companyIdentifier: item.companyIdentifier,
      dateEvent: item.dateEvent,
      timeEvent: item.timeEvent,
      timeZone: item.timeZone,
      appVersion: item.appVersion?? '',
      platform: item.platform?? '',
      clientOriginInfo: item.clientOriginInfo,
      device: DeviceMapper.fromEntityToClock(item.device),
      fenceState: getFenceState(item.fenceState),
      geolocation: LocationDto.fromEntityToClock(item.location),
      locationStatus: item.locationStatus != null ? clock.LocationStatusEnum.build(item.locationStatus!.id): null,
      geolocationIsMock: false,
      appointmentImage: item.appointmentImage,
      photoNotCaptured: item.photoNotCaptured,
      isSynchronized: item.isSynchronized,
      mode: getOperationMode(item.mode),
      online: item.online,
      origin: getOrigin(item.origin),
      employeeId: item.employeeId,
      use: int.parse(item.use),
      signature: item.signature,
      signatureVersion: item.signatureVersion,
      facialRecognitionStatus: item.facialRecognitionStatus,
      cpf: item.cpf,
    );
  }
  
  static clock.FenceStatusEnum? getFenceState(String? fenceState) {
    if (fenceState == null) {
      return null;
    }
    return clock.FenceStatusEnum.build(fenceState);
  }
  
  static clock.OperationModeEnum? getOperationMode(String? mode) {
    if (mode == null) {
      return null;
    }
    return clock.OperationModeEnum.build(mode);
  }
  
  static clock.ClockingEventOriginEnum? getOrigin(String? origin) {
    if (origin == null) {
      return null;
    }
    return clock.ClockingEventOriginEnum.build(origin);
  }
}
