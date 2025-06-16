import 'package:json_annotation/json_annotation.dart';
import '../enums/company_type.dart';
import '../enums/data_origin_type.dart';

part '../../../../../generated/app/collector/core/domain/input_model/company_dto.g.dart';

@JsonSerializable()
class CompanyDto {
  final String? id;
  final String? cnpj;
  final String? caepf;
  final String? cnoNumber;
  final String name;
  final String timeZone;
  final DataOriginType? dataOrigin;
  final String? arpId;
  String? identifier;
  CompanyType? type;

  CompanyDto({
    this.id,
    this.cnpj,
    this.caepf,
    this.cnoNumber,
    required this.name,
    required this.timeZone,
    this.dataOrigin,
    this.arpId,
    this.identifier,
    this.type,
  });

  factory CompanyDto.fromJson(Map<String, dynamic> json) =>
      _$CompanyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDtoToJson(this);
}
