import '../../infra/models/payroll_wage_types_model.dart';
import 'payroll_wage_type_model_mapper.dart';

class PayrollWageTypesModelMapper {
  PayrollWageTypesModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PayrollWageTypesModel(
      actualValue: double.parse(map['actualValue'].toString()),
      id: map['id'],
      referenceValue: map['referenceValue'],
      wageType: PayrollWageTypeModelMapper().fromMap(
        map: map['wageType'],
      ),
    );
  }
}
