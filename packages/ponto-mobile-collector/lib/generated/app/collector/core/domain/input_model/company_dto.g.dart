// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/company_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDto _$CompanyDtoFromJson(Map<String, dynamic> json) => CompanyDto(
      id: json['id'] as String?,
      cnpj: json['cnpj'] as String?,
      caepf: json['caepf'] as String?,
      cnoNumber: json['cnoNumber'] as String?,
      name: json['name'] as String,
      timeZone: json['timeZone'] as String,
      dataOrigin:
          $enumDecodeNullable(_$DataOriginTypeEnumMap, json['dataOrigin']),
      arpId: json['arpId'] as String?,
      identifier: json['identifier'] as String?,
      type: $enumDecodeNullable(_$CompanyTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CompanyDtoToJson(CompanyDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cnpj': instance.cnpj,
      'caepf': instance.caepf,
      'cnoNumber': instance.cnoNumber,
      'name': instance.name,
      'timeZone': instance.timeZone,
      'dataOrigin': _$DataOriginTypeEnumMap[instance.dataOrigin],
      'arpId': instance.arpId,
      'identifier': instance.identifier,
      'type': _$CompanyTypeEnumMap[instance.type],
    };

const _$DataOriginTypeEnumMap = {
  DataOriginType.g5: 'g5',
  DataOriginType.manual: 'manual',
};

const _$CompanyTypeEnumMap = {
  CompanyType.cnpj: 'CNPJ',
  CompanyType.cpf: 'CPF',
};
