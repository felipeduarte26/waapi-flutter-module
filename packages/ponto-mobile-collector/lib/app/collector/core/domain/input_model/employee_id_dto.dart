import 'package:json_annotation/json_annotation.dart';

part '../../../../../generated/app/collector/core/domain/input_model/employee_id_dto.g.dart';

@JsonSerializable()
class EmployeeIdDto {
  String id;
  String? arpId;
  String? pis;
  String? cpf;

  EmployeeIdDto({
    required this.id,
    this.arpId,
    this.pis,
    this.cpf,
  });

  factory EmployeeIdDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeIdDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeIdDtoToJson(this);
}
