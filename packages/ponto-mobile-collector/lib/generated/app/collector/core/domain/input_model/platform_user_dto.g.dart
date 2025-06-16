// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/platform_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlatformUserDto _$PlatformUserDtoFromJson(Map<String, dynamic> json) =>
    PlatformUserDto(
      id: json['id'] as String?,
      username: json['username'] as String,
    );

Map<String, dynamic> _$PlatformUserDtoToJson(PlatformUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
    };
