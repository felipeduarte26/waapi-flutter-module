import 'package:json_annotation/json_annotation.dart';

import 'perimeter_dto.dart';

part '../../../../../generated/app/collector/core/domain/input_model/fence_dto.g.dart';

@JsonSerializable()
class FenceDto {
  final String? id;
  final String name;
  final List<PerimeterDto>? perimeters;

  FenceDto({
    required this.name,
    this.perimeters,
    this.id,
  });

  factory FenceDto.fromJson(Map<String, dynamic> json) =>
      _$FenceDtoFromJson(json);

  Map<String, dynamic>  toJson() => _$FenceDtoToJson(this);

}
