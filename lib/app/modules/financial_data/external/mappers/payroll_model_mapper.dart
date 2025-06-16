import '../../../../core/enums/currency_type_enum.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../infra/models/payroll_model.dart';
import 'payroll_calculation_model_mapper.dart';
import 'payroll_details_model_mapper.dart';
import 'payroll_employee_model_mapper.dart';
import 'payroll_wage_types_model_mapper.dart';

class PayrollModelMapper {
  PayrollModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PayrollModel(
      amountDependentsForFamilySalary: map['quantidadeDependentesParaSalarioFamilia'],
      amountDependentsForIncomeTax: map['quantidadeDependentesParaImpostoRenda'],
      baseValueFGTS: double.parse(map['valorBaseFGTS'].toString()),
      baseValueINSS: double.parse(map['valorBaseINSS'].toString()),
      baseValueIR: double.parse(map['valorBaseIR'].toString()),
      id: map['id'],
      netValue: double.parse(map['netValue'].toString()),
      referenceSalary: double.parse(map['referenceSalary'].toString()),
      valueFGTS: double.parse(map['valorFGTS'].toString()),
      calculation: map['calculation'] != null
          ? PayrollCalculationModelMapper().fromMap(
              map: map['calculation'],
            )
          : null,
      currency: EnumHelper<CurrencyTypeEnum>().stringToEnum(
        stringToParse: map['currency'],
        values: CurrencyTypeEnum.values,
      ),
      details: map['details'] != null
          ? PayrollDetailsModelMapper().fromMap(
              map: map['details'],
            )
          : null,
      employee: map['employee'] != null
          ? PayrollEmployeeModelMapper().fromMap(
              map: map['employee'],
            )
          : null,
      wageTypes: map['wageTypes'] != null
          ? (map['wageTypes'] as List).map((wageTypes) {
              return PayrollWageTypesModelMapper().fromMap(
                map: wageTypes,
              );
            }).toList()
          : null,
    );
  }
}
