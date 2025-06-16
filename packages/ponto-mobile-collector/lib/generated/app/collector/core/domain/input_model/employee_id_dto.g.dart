// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/employee_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeIdDto _$EmployeeIdDtoFromJson(Map<String, dynamic> json) =>
    EmployeeIdDto(
      id: json['id'] as String,
      arpId: json['arpId'] as String?,
      pis: json['pis'] as String?,
      cpf: json['cpf'] as String?,
    );

Map<String, dynamic> _$EmployeeIdDtoToJson(EmployeeIdDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'arpId': instance.arpId,
      'pis': instance.pis,
      'cpf': instance.cpf,
    };
