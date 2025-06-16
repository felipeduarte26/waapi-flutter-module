import 'package:json_annotation/json_annotation.dart';

import '../enums/insight_out_of_bound_type.dart';

import '../enums/operation_mode_type.dart';
import 'clocking_event_use_dto.dart';

part '../../../../../generated/app/collector/core/domain/input_model/configuration_dto.g.dart';

@JsonSerializable()
class ConfigurationDto {
  final String? id;
  final bool onlyOnline;
  final OperationModeType operationMode;
  final String timezone;
  final bool takePhoto;
  final bool? allowChangeTime;
  final bool? faceRecognition;
  final bool? faceRecognitionSingle;
  final bool? faceRecognitionMulti;
  final String? username;
  final bool? isManager;
  final String? managerId;
  final bool? overnight;
  final bool? controlOvernight;
  final List<ClockingEventUseDto>? clockingEventUses;
  final bool? gps;
  final bool? deviceAuthorizationType;
  final bool? allowDrivingTime;
  final bool? allowGpoOnApp;
  final bool? exportNotChecked;
  final InsightOutOfBoundType? insightOutOfBound;
  final bool? openExternalBrowser;
  final bool? allowUse;
  final bool? externalControlTimezone;
  final bool? nfcMode;
  final bool? takePhotoNfc;
  final bool? takePhotoSingle;
  final bool? takePhotoDriver;
  final bool? takePhotoQrcode;

  ConfigurationDto({
    this.id,
    required this.onlyOnline,
    required this.operationMode,
    required this.timezone,
    required this.takePhoto,
    this.allowChangeTime,
    this.faceRecognition,
    this.faceRecognitionSingle,
    this.faceRecognitionMulti,
    this.username,
    this.isManager,
    this.managerId,
    this.overnight,
    this.controlOvernight,
    this.clockingEventUses,
    this.gps,
    this.deviceAuthorizationType,
    this.allowDrivingTime,
    this.allowGpoOnApp,
    this.exportNotChecked,
    this.insightOutOfBound,
    this.openExternalBrowser,
    this.allowUse,
    this.externalControlTimezone,
    this.nfcMode,
    this.takePhotoNfc,
    this.takePhotoSingle,
    this.takePhotoDriver,
    this.takePhotoQrcode,
  });

  factory ConfigurationDto.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationDtoToJson(this);
}
