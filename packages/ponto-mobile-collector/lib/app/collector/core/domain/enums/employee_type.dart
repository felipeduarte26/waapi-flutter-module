import 'package:json_annotation/json_annotation.dart';

import '../../exception/service_exception.dart';

enum EmployeeType {
  @JsonValue('COMPANY_EMPLOYEE')
  companyEmployee('COMPANY_EMPLOYEE'),

  @JsonValue('THIRD_PARTY_EMPLOYEE')
  thirdPartyEmployee('THIRD_PARTY_EMPLOYEE'),

  @JsonValue('PARTNER_EMPLOYEE')
  partnerEmployee('PARTNER_EMPLOYEE');

  final String value;

  const EmployeeType(this.value);

  static EmployeeType build(String value) {
    if (value == EmployeeType.companyEmployee.value) {
      return EmployeeType.companyEmployee;
    }

    if (value == EmployeeType.thirdPartyEmployee.value) {
      return EmployeeType.thirdPartyEmployee;
    }

    if (value == EmployeeType.partnerEmployee.value) {
      return EmployeeType.partnerEmployee;
    }

    throw ServiceException(message: 'EmployeeType not found');
  }
}
