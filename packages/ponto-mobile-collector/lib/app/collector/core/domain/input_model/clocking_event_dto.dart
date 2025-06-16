
import 'package:json_annotation/json_annotation.dart';

import '../enums/clocking_event_origin.dart';
import '../enums/location_status.dart';
import '../enums/operation_mode_type.dart';
import 'company_dto.dart';
import 'device_dto.dart';
import 'employee_dto.dart';
import 'location_dto.dart';

part '../../../../../generated/app/collector/core/domain/input_model/clocking_event_dto.g.dart';

@JsonSerializable()
class ClockingEventDto {
  String? id;
  String dateEvent;
  String timeEvent;
  String timeZone;
  String companyIdentifier;
  String? pis;
  String cpf;
  String appVersion;
  String platform;
  DeviceDto? device;
  LocationDto? geolocation;
  bool geolocationIsMock;
  String? fenceState;
  String use;
  String clockingEventId;
  OperationModeType? mode;
  bool? online;
  String signature;
  int signatureVersion;
  ClockingEventOriginEnum? origin;
  String? clientOriginInfo;
  String? appointmentImage;
  String? photoNotCaptured;
  LocationStatusEnum? locationStatus;
  bool isSynchronized;
  EmployeeDto? employeeDto;
  CompanyDto? companyDto;
  String? journeyId;
  bool? isMealBreak;
  String? facialRecognitionStatus;
  String? journeyEventName;

  ClockingEventDto({
    this.id,
    required this.dateEvent,
    required this.timeEvent,
    required this.timeZone,
    required this.companyIdentifier,
    this.pis,
    required this.cpf,
    required this.appVersion,
    required this.platform,
    this.device,
    this.geolocation,
    this.fenceState,
    required this.use,
    required this.clockingEventId,
    this.mode,
    this.online,
    required this.signature,
    required this.signatureVersion,
    this.origin,
    this.clientOriginInfo,
    this.appointmentImage,
    this.photoNotCaptured,
    this.locationStatus,
    this.isSynchronized = false,
    this.geolocationIsMock = false,
    this.employeeDto,
    this.companyDto,
    this.journeyId,
    this.isMealBreak,
    this.facialRecognitionStatus,
    this.journeyEventName,
  });

  DateTime getDateTimeEvent() {
    return DateTime.parse('$dateEvent ${timeEvent}Z');
  }

  factory ClockingEventDto.fromJson(Map<String, dynamic> json) =>
      _$ClockingEventDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ClockingEventDtoToJson(this);
}
