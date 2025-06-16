import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enum/calculation_type_enum.dart';
import '../../infra/models/payroll_calculation_model.dart';

class PayrollCalculationModelMapper {
  PayrollCalculationModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PayrollCalculationModel(
      id: map['id'],
      paymentDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['paymentDate'],
      ),
      paymentReference: map['paymentReference'],
      type: EnumHelper<CalculationTypeEnum>().stringToEnum(
        stringToParse: map['type'],
        values: CalculationTypeEnum.values,
      ),
    );
  }
}
