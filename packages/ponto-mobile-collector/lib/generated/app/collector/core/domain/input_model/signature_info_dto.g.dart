// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/signature_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureInfoDto _$SignatureInfoDtoFromJson(Map<String, dynamic> json) =>
    SignatureInfoDto(
      signature: json['signature'] as String,
      signatureVersion: json['signatureVersion'] as String?,
    );

Map<String, dynamic> _$SignatureInfoDtoToJson(SignatureInfoDto instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'signatureVersion': instance.signatureVersion,
    };
