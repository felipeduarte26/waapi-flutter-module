// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/perimeter_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerimeterDto _$PerimeterDtoFromJson(Map<String, dynamic> json) => PerimeterDto(
      type: $enumDecode(_$GeometricFormTypeEnumMap, json['type']),
      startPoint:
          LocationDto.fromJson(json['startPoint'] as Map<String, dynamic>),
      radius: (json['radius'] as num).toDouble(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$PerimeterDtoToJson(PerimeterDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$GeometricFormTypeEnumMap[instance.type]!,
      'startPoint': instance.startPoint,
      'radius': instance.radius,
    };

const _$GeometricFormTypeEnumMap = {
  GeometricFormType.circle: 'circle',
};
