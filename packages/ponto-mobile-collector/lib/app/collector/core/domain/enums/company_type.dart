import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum CompanyType {
  @JsonValue('CNPJ')
  cnpj('CNPJ'),

  @JsonValue('CPF')
  cpf('CPF');

  final String value;

  const CompanyType(this.value);

  static CompanyType build(String value) {
    if (value == CompanyType.cnpj.value) {
      return CompanyType.cnpj;
    }

    if (value == CompanyType.cpf.value) {
      return CompanyType.cpf;
    }

    throw ClockingEventException('CompanyType not found');
  }
}
