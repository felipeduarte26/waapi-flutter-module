// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/fence_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FenceDto _$FenceDtoFromJson(Map<String, dynamic> json) => FenceDto(
      name: json['name'] as String,
      perimeters: (json['perimeters'] as List<dynamic>?)
          ?.map((e) => PerimeterDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$FenceDtoToJson(FenceDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'perimeters': instance.perimeters,
    };
