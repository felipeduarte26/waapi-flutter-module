import 'package:json_annotation/json_annotation.dart';

import '../enums/clocking_event_use_type.dart';

part '../../../../../generated/app/collector/core/domain/input_model/clocking_event_use_dto.g.dart';

@JsonSerializable()
class ClockingEventUseDto {
  final String description;
  final String code;
  final ClockingEventUseType clockingEventUseType;
  final String? employeeId;

  ClockingEventUseDto({
    required this.description,
    required this.code,
    required this.clockingEventUseType,
    this.employeeId,
  });

  factory ClockingEventUseDto.fromJson(Map<String, dynamic> json) =>
      _$ClockingEventUseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClockingEventUseDtoToJson(this);

}
