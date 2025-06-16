// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/register_fcm_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterFCMTokenDto _$RegisterFCMTokenDtoFromJson(Map<String, dynamic> json) =>
    RegisterFCMTokenDto(
      token: json['token'] as String?,
      employeeId: json['employeeId'] as String?,
      platform: json['platform'] as String?,
    );

Map<String, dynamic> _$RegisterFCMTokenDtoToJson(
        RegisterFCMTokenDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'employeeId': instance.employeeId,
      'platform': instance.platform,
    };
