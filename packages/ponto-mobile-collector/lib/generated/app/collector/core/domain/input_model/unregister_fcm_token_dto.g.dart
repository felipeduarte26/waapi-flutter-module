// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/unregister_fcm_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnregisterFCMTokenDto _$UnregisterFCMTokenDtoFromJson(
        Map<String, dynamic> json) =>
    UnregisterFCMTokenDto(
      employeeId: json['employeeId'] as String?,
      platform: json['platform'] as String?,
    );

Map<String, dynamic> _$UnregisterFCMTokenDtoToJson(
        UnregisterFCMTokenDto instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'platform': instance.platform,
    };
