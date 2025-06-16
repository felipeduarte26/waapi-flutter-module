import '../../../../core/helper/enum_helper.dart';
import '../../enum/payment_type_enum.dart';
import '../../infra/models/payroll_details_model.dart';
import 'payroll_bank_payment_model_mapper.dart';

class PayrollDetailsModelMapper {
  PayrollDetailsModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PayrollDetailsModel(
      paymentType: EnumHelper<PaymentTypeEnum>().stringToEnum(
        stringToParse: map['paymentType'],
        values: PaymentTypeEnum.values,
      ),
      bankPayment: map['bankPayment'] != null
          ? (map['bankPayment'] as List).map(
              (bankPayment) {
                return PayrollBankPaymentModelMapper().fromMap(
                  map: bankPayment,
                );
              },
            ).toList()
          : null,
    );
  }
}
