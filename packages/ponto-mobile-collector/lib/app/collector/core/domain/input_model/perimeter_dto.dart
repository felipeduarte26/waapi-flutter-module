import 'package:json_annotation/json_annotation.dart';

import '../enums/geometric_form_type.dart';
import 'location_dto.dart';

@JsonSerializable()
class PerimeterDto {
  final String? id;
  final GeometricFormType type;
  final LocationDto startPoint;
  final double radius;

  PerimeterDto({
    required this.type,
    required this.startPoint,
    required this.radius,
    this.id,
  });

  factory PerimeterDto.fromJson(Map<String, dynamic> json) => PerimeterDto(
        type: $enumDecode(_$GeometricFormTypeEnumMap, (json['type'] as String).toLowerCase()),
        startPoint:
            LocationDto.fromJson(json['startPoint'] as Map<String, dynamic>),
        radius: (json['radius'] as num).toDouble(),
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'type': _$GeometricFormTypeEnumMap[type]!,
        'startPoint': startPoint,
        'radius': radius,
      };
}

const _$GeometricFormTypeEnumMap = {
  GeometricFormType.circle: 'circle',
};
