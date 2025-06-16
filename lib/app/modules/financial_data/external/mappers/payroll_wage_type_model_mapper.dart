import '../../../../core/helper/enum_helper.dart';
import '../../enum/wage_type_enum.dart';
import '../../infra/models/payroll_wage_type_model.dart';

class PayrollWageTypeModelMapper {
  PayrollWageTypeModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PayrollWageTypeModel(
      id: map['id'],
      name: map['name'],
      kind: map['kind'],
      type: EnumHelper<WageTypeEnum>().stringToEnum(
            stringToParse: map['type'],
            values: WageTypeEnum.values,
          ) ??
          WageTypeEnum.grants,
    );
  }
}
