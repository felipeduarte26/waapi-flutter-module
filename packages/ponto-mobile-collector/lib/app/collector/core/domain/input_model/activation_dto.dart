
import 'package:json_annotation/json_annotation.dart';

import '../enums/activation_situation_type.dart';
import '../enums/status_device.dart';

part '../../../../../generated/app/collector/core/domain/input_model/activation_dto.g.dart';

@JsonSerializable()
class ActivationDto  {
  final String? id;
  final StatusDevice deviceSituation;
  final ActivationSituationType employeeSituation;
  final String requestDate;
  final String requestTime;

  ActivationDto({
    required this.deviceSituation,
    required this.employeeSituation,
    required this.requestDate,
    required this.requestTime,
    this.id,
  });

  factory ActivationDto.fromJson(Map<String, dynamic> json) =>
      _$ActivationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ActivationDtoToJson(this);
}
